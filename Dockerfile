FROM bcit/alpine
LABEL maintainer="chriswood.ca@gmail.com"

ENV NODE_VERSION 8.11.1 
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# START node compile from https://github.com/nodejs/docker-node/blob/master/8/alpine/Dockerfile
RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && apk add --no-cache libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
    # gpg keys listed at https://github.com/nodejs/node#release-team
    && for key in \
        94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
        FD3A5288F042B6850C66B31F09FE44734EB7990E \
        71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
        DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
        C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
        B9AE9905FFD7803F25714661B63B535A4C206CA9 \
        56730D5401028683275BD23C23EFEFE93C4CFFFE \
        77984A986EBC2AA786BC0F66B01FBB92821C587A \
    ; do \
        gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
        gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
    && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xf "node-v$NODE_VERSION.tar.xz" \
    && cd "node-v$NODE_VERSION" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && cd .. \
    && rm -Rf "node-v$NODE_VERSION" \
    && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt
# END node compile 

RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
WORKDIR /home/node

RUN npm install --unsafe-perm -g Haraka \
    && npm cache clean --force \
    && apk del .build-deps

# create haraka config location and init config
RUN mkdir /etc/haraka \
    && mkdir /etc/haraka/queue \
    && haraka -i /etc/haraka \
    && rm /etc/haraka/config/host_list \
    && touch /etc/haraka/config/host_list

# copy commented config for smtp_forward plugin
COPY smtp_forward.ini /etc/haraka/config/

RUN chmod -R 774 /etc/haraka

COPY 50-configure-haraka.sh 60-configure-haraka-smtp-forward.sh \
    /docker-entrypoint.d/

CMD ["haraka", "-c", "/etc/haraka"]
EXPOSE 1025
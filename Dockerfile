FROM bcit/alpine

RUN apk add --no-cache \
    postfix

COPY main.cf /etc/postfix/
RUN chown -R root:root /etc/postfix/
RUN chmod -R 775 /etc/postfix

COPY 50-configure-postfix.sh /docker-entrypoint.d/ 
COPY 50-fill-sasl_passwd.sh /docker-entrypoint.d/
COPY 60-hash-sasl_passwd.sh /docker-entrypoint.d/

CMD ["/bin/sh"]
EXPOSE 587
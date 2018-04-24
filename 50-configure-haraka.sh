sed -i "s/^;listen=\[::0\]:25/listen=[::0]:1025/" /etc/haraka/config/smtp.ini
echo "$DEF_HOSTNAME" >> /etc/haraka/config/me
echo "$EMAIL_DOMAIN" >> /etc/haraka/config/host_list
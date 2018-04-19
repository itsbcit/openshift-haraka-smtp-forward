sed -i "s/##PF_HOSTNAME/$PF_HOSTNAME/" /etc/postfix/main.cf
sed -i "s/##PF_SMTP_SERVER##/$PF_SMTP_SERVER/" /etc/postfix/main.cf
sed "s/^smtp/587/" /etc/postfix/master.cf
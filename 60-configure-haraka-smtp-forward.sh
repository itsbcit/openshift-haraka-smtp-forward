if [ "$SMTP_FORWARD" = true ]; then
    sed -i "s/;enable_outbound=\[true\]/enable_outbound=true/" /etc/haraka/config/smtp_forward.ini
    sed -i "s/;host=#SMTP_HOST/host=$SMTP_FWD_HOST/" /etc/haraka/config/smtp_forward.ini
    sed -i "s/;port=#SMTP_PORT/port=$SMTP_FWD_PORT/" /etc/haraka/config/smtp_forward.ini
    sed -i "s/;enable_tls=\[true\]/enable_tls=true/" /etc/haraka/config/smtp_forward.ini
    sed -i "s/;auth_type=\[plainlogin\]/auth_type=$SMTP_FWD_AUTHTYPE/" /etc/haraka/config/smtp_forward.ini
    sed -i "s/;auth_user=#SMTP_USERNAME/auth_user=$SMTP_FWD_USERNAME/" /etc/haraka/config/smtp_forward.ini
    sed -i "s/;auth_pass=#SMTP_PASSWORD/auth_pass=$SMTP_FWD_PASSWORD/" /etc/haraka/config/smtp_forward.ini
fi

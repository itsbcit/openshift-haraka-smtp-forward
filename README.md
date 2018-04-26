The following environmental variables are required to be set for proper functionality

**$DEF_HOSTNAME**=[name of your haraka-smtp host] 

**$EMAIL_DOMAIN**=[domain of valid hosts ie. google.com; currently only 1, extend by appending to /etc/haraka/config/host_list] 

**$SMTP_FORWARD**=[true or false, if true, enables forwarding of emails to the following variables; if false, haraka just receives email and does nothing with them. They will be lost as /etc/haraka/queue is not peristent] 

**$SMTP_FWD_HOST**=[hostname of where you'd like to forward emails to] 

**$SMTP_FWD_PORT**=[port of host of where you'd like to forward emails to] 

**$SMTP_FWD_AUTHTYPE**=[plain or login, authentication method for above host] 

**$SMTP_FWD_USERNAME**=[plaintext username for the above host] 

**$SMTP_FWD_PASSWORD**=[plaintext password for the above host]

#Notes
Email service sendin to this haraka container must have a hostname configured that can be resolved or else haraka rejects with: 

``550 No MX for your FROM address``
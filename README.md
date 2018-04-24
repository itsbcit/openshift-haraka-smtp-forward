The following environmental variables are required to be set for proper functionality

$DEF_HOSTNAME=[name of your haraka-smtp host]
$EMAIL_DOMAIN=[domain of valid hosts ie. google.com; currently only 1, extend by appending to /etc/haraka/config/host_list]

$SMTP_FORWARD=[true or false, if true, enables forwarding of emails to the following variables; if false, the entire container probably does nothing]
$SMTP_FWD_HOST=[hostname of where you'd like to forward emails to]
$SMTP_FWD_PORT=[port of host of where you'd like to forward emails to]
$SMTP_FWD_AUTHTYPE=[plain or login, authentication method for above host]
$SMTP_FWD_USERNAME=[plaintext username for the above host]
$SMTP_FWD_PASSWORD=[plaintext password for the above host]
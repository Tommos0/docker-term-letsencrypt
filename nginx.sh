#!/bin/sh
cat /etc/envvars
source /etc/envvars
envsubst '\$SSL_DOMAINS \$SSL_FORWARD' < /nginx.conf > /nginx2.conf
cat /nginx2.conf
exec /usr/sbin/nginx -g "daemon off;"

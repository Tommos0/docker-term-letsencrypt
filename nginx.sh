#!/bin/sh
source /etc/envvars
envsubst '\$SSL_DOMAINS \$SSL_FORWARD' < /nginx.conf > /etc/nginx/conf.d/default.conf
exec /usr/sbin/nginx -g "daemon off;"

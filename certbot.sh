#!/bin/sh
source /etc/envvars
DOMAIN_PARAMS="-d $(echo $SSL_DOMAINS | sed 's/,/ -d /g')"
( set -x; certbot certonly --webroot -w /acme -n --agree-tos --email ${SSL_ADMIN_EMAIL} ${DOMAIN_PARAMS} --expand )
if [ $? -ne 0 ]; then
    echo "WARNING: Certbot failed to create certificate"
    exit 1
else
  ls /etc/letsencrypt/live
    #cp -r -L /etc/letsencrypt/live/${DOMAIN}/*.pem /cert
fi

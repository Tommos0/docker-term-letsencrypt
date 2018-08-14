# docker-term-letsencrypt
docker / nginx / Let's encrypt SSL termination/proxy.

This Docker container can be used as a reverse proxy between the internet and the rest of your application.
It takes care of encryption and acquisition & automatic renewal of HTTPS certificates using Let's encrypt / Certbot.

## How to use
Configuration is done through the `.env` file:
```
# The domains to request the certificate for, seperated by a comma
SSL_DOMAINS=mydomain.org,www.mydomain.org
# The proxy to forward requests to (probably another container in your Docker network)
SSL_FORWARD=http://localhost:80
# The admin email (this is required when requesting a certificate)
SSL_ADMIN_EMAIL=admin@mydomain.org
```
Let's encrypt has a [rate limit](https://letsencrypt.org/docs/rate-limits/) of a few generated certificates per domain per month, so you cannot just generate new certificates every time container is restarted.
So you should keep the generated certificates and config by mounting persisted volumes at:
- `/etc/letsencrypt`
- `/cert`

Make sure to bind ports `80` and `443` of course.

E.g. to run standalone:
- `docker build . -t docker-term-letsencrypt`

```
docker run -it \
  --env-file .env \
  -p80:80 \
  -p443:443 \
  -v`pwd`/cert:/cert \
  -v`pwd`/letsencrypt:/etc/letsencrypt \
  docker-term-letsencrypt
```

#!/bin/bash
mkdir -p /usr/local/nginx/ssl/certs/ 
cd /usr/local/nginx/ssl/certs/

/build/openssl-OpenSSL_1_1_0h/apps/openssl req -nodes -newkey rsa:2048 -keyout server.key -out server.csr -subj "/C=DC/ST=DC/L=DC/O=DC/OU=DC/CN=Dc"
/build/openssl-OpenSSL_1_1_0h/apps/openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

cd /build/

/usr/local/nginx/sbin/nginx &

/bin/bash

#!/bin/bash
mkdir -p /usr/local/nginx/ssl/certs/ 
cd /usr/local/nginx/ssl/certs/

/usr/local/ssl/bin/openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout server.key -out server.crt -extensions san -config <(echo "[req]"; echo distinguished_name=req; echo "[san]"; echo subjectAltName=DNS:example.com,DNS:example.net,IP.1:127.0.0.1,IP.2:$(hostname -i)) -subj /CN=example.com

/usr/local/nginx/sbin/nginx &
iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 443
iptables -t nat -A PREROUTING -p udp --dport 1:65535 -j REDIRECT --to-ports 443
cd /usr/local/nginx/
/bin/bash

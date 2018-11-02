#!/bin/bash

HostIP=10.10.0.36
export HostIP

sudo docker stop etcd-hpe
sudo docker rm etcd-hpe

sudo docker run -d -v /etc/etcd/pki:/etc/ssl/certs -p 4002:4002 \
-p 3380:3380 -p 3379:3379 \
--name etcd-hpe quay.io/coreos/etcd:v2.2.0 \
-name etcd0 \
-advertise-client-urls https://${HostIP}:3379,https://${HostIP}:4002 \
-listen-client-urls https://0.0.0.0:3379,https://0.0.0.0:4002 \
-initial-advertise-peer-urls https://${HostIP}:3380 \
-listen-peer-urls https://0.0.0.0:3380 \
-initial-cluster-token etcd-cluster-1 \
-initial-cluster etcd0=https://${HostIP}:3380 \
-initial-cluster-state new \
--cert-file=/etc/ssl/certs/server.crt \
--key-file=/etc/ssl/certs/server.key \
--trusted-ca-file=/etc/ssl/certs/ca.crt \
--client-cert-auth \
--peer-cert-file=/etc/ssl/certs/peer.crt \
--peer-key-file=/etc/ssl/certs/peer.key \
--peer-client-cert-auth

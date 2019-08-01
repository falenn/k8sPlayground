#!/bin/bash

# To install etcd, run ./etcd-standalone true
#
#
install=$1

export HostIP=`hostname -i`
echo "HostIP: $HostIP"

sudo docker ps | grep etcd0

if [[ "$install" = "true" ]]; then
if [[ "$?" = "0" ]]; then
echo "Starting etcd standalone for HPE 3Par"
sudo docker stop etcd0
sudo docker rm etcd0
fi
sudo docker run -d \
-v /usr/share/ca-certificates/:/etc/ssl/certs \
-p 5001:3001 \
-p 3380:3380 \
-p 3379:3379 \
--name etcd0 quay.io/coreos/etcd:v2.2.0 \
-name etcd0 \
-advertise-client-urls http://${HostIP}:3379,http://${HostIP}:5001 \
-listen-client-urls http://0.0.0.0:3379,http://0.0.0.0:5001 \
-initial-advertise-peer-urls http://${HostIP}:3380 \
-listen-peer-urls http://0.0.0.0:3380 \
-initial-cluster-token etcd-cluster-1 \
-initial-cluster etcd0=http://${HostIP}:3380 \
-initial-cluster-state new
fi

echo "testing access"

echo "Testing access"


echo "Test access to etcd"
curl $HostIP:3379/v2/keys
echo "Result: $?"

echo "test put of key"
curl $HostIP:3379/v2/keys/foo -XPUT -d value=bar
echo "Result: $?"

echo "get stats on cluster"
curl $HostIP:3379/v2/stats/leader


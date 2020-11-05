#!/bin/bash

DOCKER_VER=19.*

sudo yum install -y yum-utils
sudo yum --enablerepo=extras install epel-release

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum-config-manager --disable docker-ce-edge
sudo yum-config-manager --disable docker-ce-test

wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.119.2-1.911c772.el7_8.noarch.rpm -O container-selinux.rpm

sudo yum install -y container-selinux.rpm
#sudo yum install -y container-selinux
sudo yum install -y docker-ce-$DOCKER_VER

# Docker config
# overlay2 requires xfs formatted without d_type support.
sudo mkdir -p /etc/docker
sudo rm /etc/docker/daemon.json

cat << 'EOF' | sudo tee /etc/docker/daemon.json
{ 
  "storage-driver":"devicemapper",
  "exec-opts": ["native.cgroupdriver=systemd"],
  "data-root": "/data/docker",
  "log-driver":"json-file",
  "log-opts":{
    "max-size":"10m",
    "max-file": "2"
  },
  "dns": ["8.8.8.8"]
}
EOF


# docker tab completion
#curl -L https://raw.githubusercontent.com/docker/docker-ce/v$(docker -v | cut -d' ' -f3 | tr -d ',')/components/cli/contrib/completion/bash/docker | sudo tee /etc/bash_completion.d/docker

# docker compose completion
#curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose | sudo tee /etc/bash_completion.d/docker-compose

# disable swap
sudo swapoff -a

# Disable swap
sudo swapoff -a

# start the service
sudo systemctl enable docker
sudo systemctl start docker



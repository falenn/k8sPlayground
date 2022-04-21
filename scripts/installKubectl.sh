#!/bin/bash

REPO=/etc/yum.repos.d/kubernetes.repo

if [[ -f "$REPO" ]]; then
  sudo rm $REPO
fi

sudo cat <<EOF | sudo tee -a ${REPO}
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF


# install kube binaries
sudo yum install -y kubectl --disableexcludes=kubernetes




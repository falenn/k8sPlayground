#!/bin/bash


sudo cat <<EOF | sudo tee -a /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


sudo cat <<EOF | sudo tee -a /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

#disable swap
sudo swapoff -a

#disable selinux
sudo setenforce 0

# install kube binaries
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl stop kubelet
sudo systemctl enable kubelet && sudo systemctl start kubelet

sudo kubeadm reset

# initialize master and set network CIDR for CNI
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# install flannel
curl -LJO https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
sudo kubectl apply -f kube-flannel.yml

#allow scheduling on the master
sudo kubectl taint nodes --all node-role.kubernetes.io/master-

# setup kubectl for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config

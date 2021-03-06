#!/bin/bash

POD_CIDR="10.244.0.0/16"
INIT_SCRIPT=kubeadm-init2-config.yaml
sudo rm /etc/sysctl.d/k8s.conf
#sudo touch /etc/sysctl.d/k8s.conf

sudo cat <<EOF | sudo tee -a /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

function installCNI {
echo "CNI function"
# install Calico

#curl https://docs.projectcalico.org/manifests/calico.yaml -O
#sed -i -e "s?192.168.0.0/16?$POD_CIDR?g" calico.yaml

#kubectl apply -f calico.yaml


# install flannel
# curl -LJO https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
# sudo kubectl apply -f kube-flannel.yml

}


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
# sudo kubeadm init --pod-network-cidr=$POD_CIDR
sudo kubeadm init --config $INIT_SCRIPT


# setup kubectl for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config


# Proceed when cluster is running
READY=`kubectl get nodes`
while [ $READY -ne 0 ]; do
  sleep 5
  READY=`kubectl get nodes`
done


#allow scheduling on the master
kubectl taint nodes --all node-role.kubernetes.io/master-

# Install CNI

installCNI






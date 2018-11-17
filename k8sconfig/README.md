# k8s install

# install docker from this repo which uses cgroupfs by isDefault
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg

# install go
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
add export PATH=$PATH:/usr/local/go/bin to .bash_profile

#make sure we can reach gcr.io
kubeadm config images pull
export TOKEN=`kubeadm token generate`
kubeadm init \
  --ignore-preflight-errors='Swap' \
  --token=$TOKEN  \
  --pod-network-cidr=10.244.0.0/16 \
  --cgroup-driver=cgroupfs \
  --network-plugin=cni

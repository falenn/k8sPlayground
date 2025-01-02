Follow instructions here: https://docs.rke2.io/install/methods

1. Install some tools
```
sudo dnf install -y tmux curl wget jq
```

2. Create rke2-calico.conf file for NetworkManager to avoid trying to configure interfaces created by CNI:
vi /etc/NetworkManager/conf.d/rke2-install.md
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:flannel*
```

restart networkmanager
```
sudo systemctl status NetworkManager
```

3. Install rke2
```
curl -sfL https://get.rke2.io | sudo sh -
```

Add public IP config here to /etc/rancher/rke2/config.yaml
```
write-kubeconfig-mode: "0600"
tls-san:
  - "publichost.domain.com"
  - "172.222.222.222"
```

4. Enable and start rke2 server
```
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
```

5. Setting up kubectl
Copy kube config
```
mkdir -p ~/.kube
sudo cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
sudo chown cloud_user: ~/.kube/config
```

Install kubernetes.repo
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
```
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
EOF
```
Install kubectl
```
sudo dnf install -y kubectl
```

6. After installing on other nodes, join them using the join token, found at `/var/lib/rancher/rke2/server/node-token`.








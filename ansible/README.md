# K8s Install
NOTE: This does require Docker presidence on an installer node (perhaps the master) to run Ansible from Docker.

ansible-playbook k8s-install.yml 

# Vars Help
Check vars collected for a given host from /group_vars/all
ansible-inventory -i inventory.txt --host <hostname or IP>
  or
ansible -u root -i inventory.txt -m setup <hostname or IP>

# Help / References
Help from https://github.com/magic7s/ansible-kubeadm-contiv

https://medium.com/@perwagnernielsen/ansible-tutorial-part-2-installing-packages-41d3ab28337d

# Other Centos Guides
https://phoenixnap.com/kb/how-to-install-kubernetes-on-centos

# Items to fix
## flannel install
https://gist.github.com/rkaramandi/44c7cea91501e735ea99e356e9ae7883

## untaint master for stand-alone instance
kubectl taint node mymasternode node-role.kubernetes.io/master:NoSchedule-

# Items to Add
## Rook / Ceph
git clone https://github.com/linuxacademy/content-kubernetes-helm.git ./rook
cd ./rook/cluster/examples/kubernetes/ceph


kubectl create -f operator.yaml
Once the agent, operator and discover pods are started in the rook-ceph-system namespace then setup the cluster

kubectl create -f cluster.yaml
Once this is run wait for the appearance of the OSD pods in the name space rook-ceph

kubectl get pods -n rook-ceph
Create a storage class so that we can attach to it.

kubectl create -f storageclass.yaml

## Add Helm Install
for Centos, 
```
curl https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz --output helm-v3.0.2-linux-amd64.tar.gz
curl https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz.sha256 --output helm-v3.0.2-linux-amd64.tar.gz.sha256
echo `sha256sum helm-v3.0.2-linux-amd64.tar.gz` >> helm-sha256
# check the sha
diff helm-sha256 helm-v3.0.2-linux-amd64.tar.gz.sha256
# unpack
mkdir helm
tar -xvf -C helm helm-v3.0.0-linux-amd64.tar.gz

#Remember, when running helm init, it uses kubectl.  Kubectl must work from the location that you are installing helm from AND you must #have cluster admin rights.

mkidr ~/bin
ln -s <helm binary location> ~/bin/helm

# to add helm bash auto-complete
yum install bash-completion bash-completion-extras
```

## About Helm
local helm repo stored at ~/.helm/repository

### Create your own chart
```
mkdir helmcharts
cd helmcharts
helm create examplechart
cd examplechart
ls
cat Chart.yaml
```

We can download charts and / or put them in the local index. 
We can also add private repos / charts.

### Create private repo
Can use private repos - S3, Github, etc.





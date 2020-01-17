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


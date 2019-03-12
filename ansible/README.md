# K8s Install
To run,

This does require kubeadm install presidence.  That sucks.
ansible-playbook k8s-install.yml --extra-vars "kubeadm_token=`kubeadm token generate`"

I actually 

# Help / References
Help from https://github.com/magic7s/ansible-kubeadm-contiv

https://medium.com/@perwagnernielsen/ansible-tutorial-part-2-installing-packages-41d3ab28337d

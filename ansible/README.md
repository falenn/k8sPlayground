# K8s Install
To run,

This does require kubeadm install presidence.  That sucks.
ansible-playbook k8s-install.yml 

I actually want to make sure kubeadm is installed, then run the token generate on the
master and store that value in a variable that I use later.

# Help / References
Help from https://github.com/magic7s/ansible-kubeadm-contiv

https://medium.com/@perwagnernielsen/ansible-tutorial-part-2-installing-packages-41d3ab28337d

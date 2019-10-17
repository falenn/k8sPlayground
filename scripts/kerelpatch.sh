#!/bin/bash


hostname -i
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo yum install https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm
sudo yum --enablerepo=elrepo-kernel install kernel-ml
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
yum repolist all

# one or the other
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2-efi.cfg 
sudo grub2-set-default 0
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo reboot

# so, this is done after reboot - may take awhile
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2-efi.cfg 
sudo cat /etc/redhat-release 
sudo yum remove docker-ce containerd.io kubelet kubeadm kubectl -y
sudo yum update -y


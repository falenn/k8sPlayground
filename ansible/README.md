!!Listing Hosts
hosts by default listed in /etc/ansible/hosts

!! Running ansible commands
!!! Ping
```
ansible all -m ping
```
this pings all of the hosts

!!! list in home dir
```
ansible all -a "ls -al /home/ansible"
```
```
ansible all -a "cat /var/log/messages"
```
If we are not root, we will receive a failure - return code 1.
If permission denied, set the sudo use in the ansible config file.
```
sudo ansible all -a "cat /var/log/messages"
```
This will fail as its trying to become root without the keys having been exchanged

Instead,
```
ansible all -s -a "cat /var/log/messages"
```
This will sudo after connecting as the ansible user.

To copy a file from local to remote,
```
ansible centos -m copy -a "src=test.txt dest=/tmp/test.txt"
```
This file is copied to the destination as the ansible user.   

Let's target a specific host
```
ansible ubuntu -m apt -a "name=elinks state=latest"
```
Notice the use of the module apt.  The syntax for the actions against apt, see docs:
[https://docs.ansible.com/ansible/latest/modules/apt_module.html]
The other modules we have used so far are:
copy
command
ping

Create a user on the centos box
```
ansible centos -s -m user -a "name=test"
```
so, a template for any commands,
ansible [group|host] [all] [-s sudo] [-m module] [-a module parameters]


!!!Playbook Yaml
Create the following playbook, httpd-centos.yaml
```
--- # This is an example to install HTTPD on Centos
- hosts: centos   # generally a node setup in /etc/hosts
  remote_user: ansible
  become: yes     # become root
  become_method: sudo  # in general, don't assume defaults.  Specify!
  connection: ssh
  gather_facts: yes
  vars:
    username: myuser
  tasks:
   - name: Install HTTPD on Centos7 nodes
     yum: 
      name: httpd
      state: latest
     notify: # upon success, run the following handler
      - startservice
  handlers:
   - name: startservice
     service:
       name: httpd
       state: restarted	#or start if the first time
```
 
To run this, 
```
ansible-playbook httpd-centos.yaml  
```


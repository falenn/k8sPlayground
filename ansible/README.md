# Managing Hosts and Groups
hosts and groups by default listed in /etc/ansible/hosts
Hosts should relate to their names as listed in /etc/hosts

## SSH key generataion
All hosts need to be accessible by the ansible user (or whatever user is going to be used to contact the remote hosts.)  To do so, we can generate SSH keys on the control node and copy them to the target hosts if needed:
```
ssh-keygen -t rsa -b 2048
ssh ansible@[hostname] mkdir -p ~/.ssh
cat .ssh/id_rsa.pub|ssh ansible@[hostname] 'cat >> .ssh/authorized_keys'
```
the last line is the same as ssh-copy-id

## Creating an Inventory
See the current list of hosts:
```ansible --list-hosts all
```
This lists any hosts in /etc/ansible/hosts

### ansible.cfg
To create your own inventory locally, create ansible.cfg
```
[defaults]
inventory = ./k8s.txt
```
and the k8s.txt file:
```
[master]
c0 ansible_connection=local # if you were running ansible from this host, c0 being the name

[nodes]
c1 ansible_user=ansible
c2 ansible_user=ansible
c3 ansible_user=ansible
```

# Running ansible commands
## Ping
```
ansible all -m ping
```
this pings all of the hosts

## Commands and Sudo
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

## Using Explicit Modules
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

## Command Summary
so, a template for any commands,
ansible [group|host] [all] [-s sudo] [-m module] [-a module parameters]


# Playbook Yaml
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

# Managing Hosts


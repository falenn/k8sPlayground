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

# Gathering Facts
```
ansible centos -m setup 
```

To filter the results for something in particular,
```
ansible centos -m setup -a 'filter=*ipv4*'
```

Now, only matches on ipv4 are returned

Let's now gather the facts
```
ansible all -m --tree facts
```
These facts are stored locally in the facts directory.  This lets you see all data previously returned in order to create variables, know potential state, etc.

# Variables
Variables are used in 2 ways, in our playbooks in config and passed to playbooks at runtime

File vartelnet.yaml
```
---
- hosts: '{{ hosts }}'
  remote_user: ansible
  become: yes
  become_method: sudo
  connection: ssh
  gather_facts: '{{ gather }}'
  vars:  # This is the embedded variable section that lets us parameterize the playbook
    gather: yes
    pkg: telnet
  tasks:
   - name: Install software
     yum: 
       name: '{{ pkg }}'
       state: '{{ state }}'
``` 

Notice the embedded vars section.  Also, notice that 'hosts' and 'state' are not specified.  We will have to pass this var in upon execution...
```
ansible-playbook vartelnet.yaml --extra-vars "hosts=centos state=latest"
```

# Debugging
Well, yes, this is needed.
```
# stow.yml
--- # playbook showing debug
- hosts: centos
  remote_user: ansible
  become: yes
  become_method: sudo
  connection: ssh
  gather_facts: no
  tasks:
   - name: Install stow
     yum:
       name: stow
       state: latest
     register: result
   - debug: var=result 
```

to run with the result status passed into the debug module, we then see more output now encoded in json:

```
ansible-playbook stow.yml
```
Not all task modules are able to register results, but if not, they will tell you.

# Notification and Handling
```
# nginx.yml
--- # playbook showing notifications and handlers
- hosts: '{{ hosts }}'
  remote_user: ansible
  become: yes
  become_method: sudo
  gather_facts: yes
  connection: ssh
  tasks:
   - name: install NGinX 
     yum:
       name: nginx
       state: latest
    - name: enable nginx as a service
       service: nginx
       enabled: yes
       state: restarted
```
When this runs,we see that this requires epel-release

Running the first time installs it.
Running it a second time, it is just restarted, including every subsequent time.
Always restarting the service may be problematic, so we want to know if its running already.

```
...
  tasks: 
   - name: install NGinX
     yum: 
       name: nginx
       state: latest
     notify:
      - enable nginx as a service
  handlers:  # This is the section to add to receive the event that NGinX was installed.  The service
	     # task name must match the name of the - notify: name in the firing task.
	     # The task service will only run if the notification is received.
   - name: enable nginx as a service
     service: 
       name: nginx
       state: restarted    

```
Notice the service task only runs when the task yum fires the notify event, when it will do only upon sucess.  Since nginx is already installed, the yum task will not fire the notify event and thus the service will not restart.


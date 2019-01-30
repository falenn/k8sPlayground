!!Listing Hosts
hosts by default listed in /etc/ansible/hosts

!! Running ansible commands
!!! Ping
ansible all -m ping

this pings all of the hosts

!!! list in home dir
ansible all -a "ls -al /home/ansible"

ansible all -a "cat /var/log/messages"
If we are not root, we will receive a failure - return code 1.
If permission denied, set the sudo use in the ansible config file.

sudo ansible all -a "cat /var/log/messages"
This will fail as its trying to become root without the keys having been exchanged

Instead,
ansible all -s -a "cat /var/log/messages"
This will sudo after connecting as the ansible user.

To copy a file from local to remote,
ansible centos -m copy -a "src=test.txt dest=/tmp/test.txt"
This file is copied to the destination as the ansible user.   

Let's target a specific host
ansible ubuntu -m apt -a "name=elinks state=latest"



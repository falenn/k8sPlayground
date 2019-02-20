FROM williamyeh/ansible:centos7

RUN pip install --upgrade pip && \
    pip install hvac pbr jinja2

VOLUME [ "/sys/fs/cgroup", "/run" ]

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ] 

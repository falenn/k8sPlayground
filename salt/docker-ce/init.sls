docker-ce:
  pkg.installed: []
  service.running:
   - name: docker
   - enable: True
   - prereq:
     - pkg: upgrade_libseccomp
     - pkg: yum-utils
     - pkg: device-mapper-persistent-data
     - pkg: lvm2
     - cmd: docker-repo
   - watch:
     - file: /etc/docker/daemon.json

yum-utils:
  pkg.installed: []

device-mapper-persistent-data:
  pkg.installed: []

lvm2:
  pkg.installed: []

docker-repo:
  cmd.run:
    - name: yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    - creates: /etc/yum.repos.d/docker-ce.repo

upgrade_libseccomp:
  pkg.installed:
    - version: libseccomp-2.3.1-3.el7.x86_64

/etc/systemd/system/docker.service.d:
  file.directory:
    - user: root
    - group: root
    - mode: 660
    - makedirs: True

/etc/docker:
  file.directory:
    - user: root
    - group: root
    - mode: 660
    - makedirs: True

/home/docker:
  file.directory:
    - user: root
    - group: root
    - mode: 770
    - makedirs: True

/etc/systemd/system/docker.service.d/docker.conf:
  file.managed:
    - source: salt://etc/systemd/system/docker.service.d/docker.conf
    - user: root
    - group: root
    - mode: 660

/etc/docker/daemon.json:
  file.managed:
    - source: salt://etc/docker/daemon.json
    - user: root
    - group: root
    - mode: 660

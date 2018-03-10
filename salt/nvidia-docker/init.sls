
/etc/yum.repos.d/nvidia-docker.repo:
  file.managed:
   - source: salt://srv/salt/etc/yum.repos.d/nvidia-docker.repo


nvidia-docker2:
  pkg.installed

service stop dockerd


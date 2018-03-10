
# libs to install as dependencies for GPU drivers
# install if node has grain.gpu == nvidia
epel-release
  pkg.installed:

dkms
  pkg.installed:

libstdc++.i686i
  pkg.installed:


/etc/modprobe.d/blacklist-nouveau.conf
  file.managed:
    - source: /srv/salt/etc/modprobe.d/blacklist-nouveau.conf

service stop gdm 

download the driver via wget
cd ~ wget http://us.download.nvidia.com/XFree86/Linux-x86_64/390.25/NVIDIA-Linux-x86_64-390.25.run

sudo ./NVIDIA-Linux-x86_64-384.69.run --dkms -s

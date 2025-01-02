Follow instructions here: https://docs.rke2.io/install/methods

1. Create rke2-calico.conf file for NetworkManager to avoid trying to configure interfaces created by CNI:
vi /etc/NetworkManager/conf.d/rke2-install.md
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:flannel*
```

restart networkmanager
```
systemctl status NetworkManager
```


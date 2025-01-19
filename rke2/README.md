# RKE2 Install Overview

## Environment setup
First of all, ssh is easier in some cases by forwarding your identity to the target host.

Add your Key-pair to SSH Agent
```
ssh-add ~/.ssh/id_rsa
```

Add an entry to `~/.ssh/config` for the host:
```
Host example.com
    ForwardAgent yes
```

SSH to the host as normal.  If you don't add the above config, you will have to supply `-A` when you ssh.



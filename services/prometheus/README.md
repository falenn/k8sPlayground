# Prometheus quickstart for Docker Compose
## Storage Options
[https://docs.docker.com/engine/reference/commandline/volume_create/#options](https://docs.docker.com/engine/reference/commandline/volume_create/#options)
Storage uses volumes created and managed with docker directly
For example, an NFS target: 
```docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=192.168.1.1,rw \
    --opt device=:/path/to/dir \
    prometheus_data
```

Using a cloud provider or other provisioning, docker can mount a disk partition using
type=ext4 for example
```docker volume create prometheus_data

```

Let's create a local docker volume



# install the repo

helm repo add csi-wekafs https://weka.github.io/csi-wekafs

# Installation of the weka client



# install wekafs
## wekafs-csi-plugin using API-type installation
According to the documentation, the API-style storageclass is preferred.

Create the secret for the storageclass to specify the weka filesystem name to use, username, pwd and organization as well.  The user must have admin over the organzation the
filesystem is in.  The filesystem must be mounted by this user as well.

```
helm install csi-wekafs csi-wekafs/csi-wekafsplugin --namespace csi-wekafs --create-namespace
```

# Examples
## Example 1 
This example shows dynamic allocation for a single pod via PVC in the read/write/once (rwo) mode, requesting an allocation of 1GB.

## Example 2
This example shows static allocation of a PV in read/write/many (rwx) mode for multiple pods, setting an allocation of 1 GB.  The pods are restricted to nodes by
node name, using a label:
```
kuebctl label nodes compute1 name=compute1
kubectl label nodes compute2 name=compute2
```

The pod specs have nodeSelectors looking for corresponding node names.  When running, shell into one, write a file in /data.  In the other pod, shell in and observe the 
file being written, etc.

 

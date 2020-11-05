#!/bin/bash


#curl -O -L  https://github.com/projectcalico/calicoctl/releases/download/v3.16.4/calicoctl
#kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
#kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml

kubectl create -f tigera-operator.yaml

# edited CIDR to match kubeadm init 
kubectl create -f custom-resources.yaml

# for calicoctl in k8s support
kubectl apply -f https://docs.projectcalico.org/manifests/calicoctl-etcd.yaml


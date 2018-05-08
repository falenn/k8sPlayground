#!/bin/bash

#Putting labels on objects in Kubernetes allow you to identify and select objects in as wide or granular style as you like.
kubectl get nodes --show-labels
#1. Label each of your nodes with a "color" tag. The master should be black; node 2 should be red; node 3 should be green and node 4 should be blue.
echo "Add labels to nodes"
kubectl label nodes falenn1.mylabserver.com color=black --overwrite=true
kubectl label nodes falenn2.mylabserver.com color=red   --overwrite=true
kubectl label nodes falenn3.mylabserver.com color=green --overwrite=true
kubectl get nodes --show-labels

#2. If you have pods already running in your cluster in the default namespace, label them with the key/value pair running=beforeLabels.
echo "current pods"
kubectl get pods -o wide
echo "label running pods with running=beforeLabels"
counter=0; 
for pod in $(kubectl get pods | awk '{ print $1 }'); do 
  if [[ $counter -eq 0 ]]; then
    echo "column header:"
  else
    echo "this is pod $counter: $pod. labelling running=beforeLabels";   
    kubectl label pods $pod running=beforeLabels --overwrite=true
  fi
  ((counter++))
done
kubectl get pods --show-labels
#3. Create a new alpine deployment that sleeps for one minute and is then restarted from a yaml file that you write that labels these container with the key/value pair running=afterLabels.

#4. List all running pods in the default namespace that have the key/value pair running=beforeLabels.

#5. Label all pods in the default namespace with the key/value pair tier=linuxAcademyCloud.

#6. List all pods in the default namespace with the key/value pair running=afterLabels and tier=linuxAcademyCloud.



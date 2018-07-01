#!/bin/bash


# Label a node "gigabit" to simulate targetted  scheduling

kubectl label node falenn3.mylabserver.com net=gigabit

# view the label
kubectl get nodes falenn3.mylabserver.com --show-labels

# Now, run the Deployement with the "nodeSelector" set to net=gigabit

kubectl create -f alpine-runon-gigabit-node.yaml

sleep 2

# Display the deployment
kubectl get pods -a --show-labels -o wide

sleep 5s

kubectl delete deployments  alpine-sleeper

# remove the label

kubectl label node falenn3.mylabserver.com net-

# Inspect that node3 has the label removed
kubectl get nodes falenn3.mylabserver.com --show-labels

kubectl delete -f proxy-pod.yaml; ./cleark8scsr.sh; ./db.sh; kubectl create -f proxy-pod.yaml; sleep 8 && ./approvek8scsr.sh

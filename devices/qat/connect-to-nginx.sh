kubectl exec -it -n nginxscp `kubectl get pod -n nginxscp | grep -m 1 nginx | awk '{print $1}' ` bash 

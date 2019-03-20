kubectl exec -it -n nginxscp `kubectl get pod -n nginxscp | grep -n ".*" | grep ${1}\: | sed 's/^..//' | awk '{print $1}' ` bash 

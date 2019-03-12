kubectl exec -it -n nginxscp `kubectl get pod -n nginxscp | grep -m 1 nginx | awk '{print $1}' ` -c iperf2-container /bin/sh

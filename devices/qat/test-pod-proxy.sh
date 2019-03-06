wget -S --secure-protocol=auto --ca-certificate=server.crt https://$(kubectl get pod $(kubectl get pod | grep -i nginxproxied.* | awk '{print $1}') -o yaml | grep -i podip | awk '{print $2}'):4000

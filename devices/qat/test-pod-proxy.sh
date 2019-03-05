wget -S --secure-protocol=auto --ca-certificate=server.crt https://$(kubectl get pod nginxproxied-pod -o yaml | grep -i podip | awk '{print $2}'):4000

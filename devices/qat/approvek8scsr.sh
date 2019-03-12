for x in `kubectl get csr | grep -i pending | awk '{print $1}' | grep nginx`;do kubectl certificate approve ${x};done

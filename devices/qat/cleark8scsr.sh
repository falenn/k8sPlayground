for x in `kubectl get csr | awk '{print $1}' | grep nginx`;do kubectl delete csr ${x};done

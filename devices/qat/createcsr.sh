cat <<EOF > csr.json
{
"apiVersion": "certificates.k8s.io/v1beta1", 
"kind": "CertificateSigningRequest",
"metadata": {
  "name": "nginx-sidecar-csr-$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5 ; echo '')", 
  "namespace": "nginx-sidecar"
  }, 
"spec": {
  "groups": [ "system:serviceaccounts", "system:serviceaccounts:nginxscp", "system:authenticated"],
  "request": "$(cat server.csr | base64 | tr -d '\n')", 
  "usages": ["digital signature", "key encipherment", "server auth"]
  }
}
EOF

#!/bin/bash
mkdir -p /usr/local/nginx/ssl/certs/ 
cd /usr/local/nginx/ssl/certs/


## Certfooi
#export KUBE_TOKEN=$(</var/run/secrets/kubernetes.io/serviceaccount/token)
#curl --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt -sSk -H "Authorization: Bearer $KUBE_TOKEN" https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/api/v1/namespaces/nginx-sidecar/pods/nginxproxied-pod

# if in k8s then request a signed cert for nginx, else docker testing
if [[ -n "$KUBERNETES_SERVICE_HOST" ]];then
# k8s namespace signed cert
/usr/local/ssl/bin/openssl genrsa -out server.key 2048
/usr/local/ssl/bin/openssl req -new -key server.key -out server.csr -extensions san -config <(echo "[req]"; echo distinguished_name=req; echo "[san]"; echo subjectAltName=DNS:example.com,DNS:example.net,IP.1:127.0.0.1,IP.2:$(hostname -i),IP.3:$(hostname)) -subj "/CN=nginxscp.com"

#randomize-csr-name
CSR_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5 ; echo '')

cat <<EOF > csr.json
{
"apiVersion": "certificates.k8s.io/v1beta1", 
"kind": "CertificateSigningRequest",
"metadata": {
  "name": "nginx-sidecar-csr-${CSR_NAME}", 
  "namespace": "nginx-sidecar"
  }, 
"spec": {
  "groups": [ "system:serviceaccounts", "system:serviceaccounts:nginxscp", "system:authenticated"],
  "request": "$(cat server.csr | base64 | tr -d '\n')", 
  "usages": ["digital signature", "key encipherment", "server auth"]
  }
}
EOF
# check for existance of csr

# post csr
curl -v --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt -sSk -H "Content-Type: application/json" -H"Authorization: Bearer $(</var/run/secrets/kubernetes.io/serviceaccount/token)" -X POST -d @csr.json https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/apis/certificates.k8s.io/v1beta1/certificatesigningrequests

# check for creation of csr

# post approval

# watch for cert

# get csr ## includes status certificate section if valid.
SERVERCERT=""
while [[ -z "${SERVERCERT}" ]] ;do

SERVERCERT="$(curl --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt -sSk -H "Content-Type: application/json" -H"Authorization: Bearer $(</var/run/secrets/kubernetes.io/serviceaccount/token)" https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/apis/certificates.k8s.io/v1beta1/certificatesigningrequests/nginx-sidecar-csr-${CSR_NAME} | grep -A 10 status | grep \"certificate\" | awk '{print $2}' | tr -d \"\\n )" 
sleep 1
echo "waiting on approval"
done

echo "certificate approved!"
echo ${SERVERCERT} | base64 -d > server.crt


else
# self signed cert
/usr/local/ssl/bin/openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout server.key -out server.crt -extensions san -config <(echo "[req]"; echo distinguished_name=req; echo "[san]"; echo subjectAltName=DNS:example.com,DNS:example.net,IP.1:127.0.0.1,IP.2:$(hostname -i)) -subj /CN=example.com
fi

ulimit -l 2048

/usr/local/nginx/sbin/nginx &
iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 443
iptables -t nat -A PREROUTING -p udp --dport 1:65535 -j REDIRECT --to-ports 443
cd /usr/local/nginx/

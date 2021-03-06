#!/bin/bash
# @ajbouhajbouh/create-registry.sh
# <script src="https://gist.github.com/ajbouh/ea07868d3c6aa2e678560701de8c44ce.js"></script>
# Create a private Docker registry on a fresh Kubernetes Cluster
# create-registry.sh
set -ex

kubectl create namespace dev-support

REGISTRY_INGRESS_IP=192.168.2.9
REGISTRY_INGRESS_REGISTRY_INGRESS_HOSTNAME=registry.$REGISTRY_INGRESS_IP.default.cluster.local

# if [ ! -e $REGISTRY_INGRESS_HOSTNAME.key ]; then
#   echo '{"CN":"'$REGISTRY_INGRESS_HOSTNAME'","hosts":[""],"key":{"algo":"rsa","size":2048}}' | cfssl gencert -config=ca-config.json -ca=ca.pem -ca-key=ca-key.pem -hostname="$REGISTRY_INGRESS_HOSTNAME" - | cfssljson -bare $REGISTRY_INGRESS_HOSTNAME
# fi

# juju ssh easyrsa/0
# sudo -i
# cd /var/lib/juju/agents/unit-easyrsa-0/charm/EasyRSA-3.0.1
# BASENAME=registry
# REQ_CN=10.73.177.126
# ./easyrsa \
#     --batch \
#     --req-cn=$REQ_CN \
#     --subject-alt-name=DNS:$REGISTRY_INGRESS_HOSTNAME,IP:$REGISTRY_INGRESS_IP \
#     build-server-full \
#     $BASENAME \
#     nopass
# cat pki/issued/$BASENAME.crt pki/issued/$BASENAME.key


DOCKERCFG=$(echo '{"{{domain}}": {"auth": "{{htpasswd-plain}}", "email": "root@localhost"}}' | \
    sed -e "s/{{domain}}/$REGISTRY_INGRESS_HOSTNAME/" \
        -e "s/{{htpasswd-plain}}/$(cat htpasswd-plain | base64 -w 0)/" | \
    base64 -w 0)

TLSCERT=$(cat $REGISTRY_INGRESS_HOSTNAME.pem | base64 -w 0)
TLSKEY=$(cat $REGISTRY_INGRESS_HOSTNAME-key.pem | base64 -w 0)
HTPASSWD=$(cat htpasswd | base64 -w 0)

SEDEXPRS=(
  "-e" "s/{{tlscert}}/$TLSCERT/g"
  "-e" "s/{{tlskey}}/$TLSKEY/g"
  "-e" "s/{{htpasswd}}/$HTPASSWD/g"
  "-e" "s/{{dockercfg}}/$DOCKERCFG/g"
  "-e" "s/{{domain}}/$REGISTRY_INGRESS_HOSTNAME/g"
)
cat <<EOF | sed ${SEDEXPRS[*]} | kubectl replace --namespace=dev-support -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    volume.beta.kubernetes.io/storage-class: spectrum-scale-fileset
    volume.beta.kubernetes.io/storage-provisioner: ubiquity/flex
  name: pvc-registry-image-store
  namespace: dev-support
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1000Gi
---
apiVersion: v1
kind: Secret
metadata:
  name: registry-tls-data
  namespace: dev-support
type: Opaque
data:
  tls.crt: {{tlscert}}
  tls.key: {{tlskey}}
---
apiVersion: v1
kind: Secret
metadata:
  name: registry-auth-data
  namespace: dev-support
type: Opaque
data:
  htpasswd: {{htpasswd}}
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: registry
  namespace: dev-support
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: registry
    spec:
      containers:
      - name: registry
        image: registry:2
        resources:
          # keep request = limit to keep this container in guaranteed class
          limits:
            cpu: 100m
            memory: 100Mi
          requests:
            cpu: 100m
            memory: 100Mi
        env:
        - name: REGISTRY_HTTP_ADDR
          value: :5000
        - name: REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY
          value: /var/lib/registry
        - name: REGISTRY_AUTH_HTPASSWD_REALM
          value: basic_realm
        - name: REGISTRY_AUTH_HTPASSWD_PATH
          value: /auth/htpasswd
        volumeMounts:
        - name: pvc-registry-image-store
          mountPath: /var/lib/registry
        - name: auth-dir
          mountPath: /auth
          readOnly: true
        ports:
        - containerPort: 5000
          name: registry
          protocol: TCP
      volumes:
      - name: auth-dir
        secret:
          secretName: registry-auth-data
---
apiVersion: v1
kind: Secret
metadata:
  name: registry-access
  namespace: dev-support
data:
  .dockercfg: {{dockercfg}}
type: kubernetes.io/dockercfg
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: registry-ingress
  namespace: dev-support
spec:
  tls:
  - hosts:
    - {{domain}}
    secretName: registry-tls-data
  rules:
  - host: {{domain}}
    http:
      paths:
      - backend:
          serviceName: registry
          servicePort: 5000
        path: /
  nodeSelector: 
    kubernetes.io/hostname: client3
EOF

kubectl patch cm nginx-load-balancer-conf -p '{"data":{"body-size":"1024m"}}'
kubectl expose deployment registry --namespace=dev-support

#!/bin/env bash
#
#

USERNAME="apiaccess"
PASSWORD="mjT8_hw2wV3s:Xm"
# default org if only one org
ORGANIZATION="Root"
ENDPOINTS="192.168.2.111:14000,192.168.2.112:14000,192.168.2.113:14000"
SCHEME="http"

USERB64=`echo -n "${USERNAME}" | base64`
PWDB64=`echo -n "${PASSWORD}" | base64`
ORGB64=`echo -n "${ORGANIZATION}" | base64`
ENDB64=`echo -n "${ENDPOINTS}" | base64`
SCHEMEB64=`echo -n "${SCHEME}" | base64`

cat << EOF > secret.yml
apiVersion: v1
kind: Secret
metadata:
  name: csi-wekafs-creds
  namespace: csi-wekafs
type: Opaque
data:
  username: ${USERB64}
  password: ${PWDB64}
  organization: ${ORGB64}
  endpoints: ${ENDB64}
  scheme: ${SCHEMEB64}
EOF

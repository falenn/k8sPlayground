#!/bin/bash
#
# Copyright 2017, 2018 Istio Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
#
# Initialization script responsible for setting up port forwarding for Istio sidecar.

function usage() {
  echo "${0} -p PORT -u UID -g GID [-m mode] [-b ports] [-d ports] [-i CIDR] [-x CIDR] [-k interfaces] [-h]"
  echo ''
  # shellcheck disable=SC2016
  echo '  -p: Specify the envoy port to which redirect all TCP traffic (default $ENVOY_PORT = 15001)'
  echo '  -u: Specify the UID of the user for which the redirection is not'
  echo '      applied. Typically, this is the UID of the proxy container'
  # shellcheck disable=SC2016
  echo '      (default to uid of $ENVOY_USER, uid of istio_proxy, or 1337)'
  echo '  -g: Specify the GID of the user for which the redirection is not'
  echo '      applied. (same default value as -u param)'
  echo '  -m: The mode used to redirect inbound connections to Envoy, either "REDIRECT" or "TPROXY"'
  # shellcheck disable=SC2016
  echo '      (default to $ISTIO_INBOUND_INTERCEPTION_MODE)'
  echo '  -b: Comma separated list of inbound ports for which traffic is to be redirected to Envoy (optional). The'
  echo '      wildcard character "*" can be used to configure redirection for all ports. An empty list will disable'
  # shellcheck disable=SC2016
  echo '      all inbound redirection (default to $ISTIO_INBOUND_PORTS)'
  echo '  -d: Comma separated list of inbound ports to be excluded from redirection to Envoy (optional). Only applies'
  # shellcheck disable=SC2016
  echo '      when all inbound traffic (i.e. "*") is being redirected (default to $ISTIO_LOCAL_EXCLUDE_PORTS)'
  echo '  -i: Comma separated list of IP ranges in CIDR form to redirect to envoy (optional). The wildcard'
  echo '      character "*" can be used to redirect all outbound traffic. An empty list will disable all outbound'
  # shellcheck disable=SC2016
  echo '      redirection (default to $ISTIO_SERVICE_CIDR)'
  echo '  -x: Comma separated list of IP ranges in CIDR form to be excluded from redirection. Only applies when all '
  # shellcheck disable=SC2016
  echo '      outbound traffic (i.e. "*") is being redirected (default to $ISTIO_SERVICE_EXCLUDE_CIDR).'
  echo '  -k: Comma separated list of virtual interfaces whose inbound traffic (from VM)'
  echo '      will be treated as outbound (optional)'
  # shellcheck disable=SC2016
  echo ''
  # shellcheck disable=SC2016
  echo 'Using environment variables in $ISTIO_SIDECAR_CONFIG (default: /var/lib/istio/envoy/sidecar.env)'
}

function dump {
    iptables-save
}

trap dump EXIT

# Use a comma as the separator for multi-value arguments.
IFS=,

# The cluster env can be used for common cluster settings, pushed to all VMs in the cluster.
# This allows separating per-machine settings (the list of inbound ports, local path overrides) from cluster wide
# settings (CIDR range)
ISTIO_CLUSTER_CONFIG=${ISTIO_CLUSTER_CONFIG:-/var/lib/istio/envoy/cluster.env}
if [ -r "${ISTIO_CLUSTER_CONFIG}" ]; then
  # shellcheck disable=SC1090
  . "${ISTIO_CLUSTER_CONFIG}"
fi

ISTIO_SIDECAR_CONFIG=${ISTIO_SIDECAR_CONFIG:-/var/lib/istio/envoy/sidecar.env}
if [ -r "${ISTIO_SIDECAR_CONFIG}" ]; then
  # shellcheck disable=SC1090
  . "${ISTIO_SIDECAR_CONFIG}"
fi

# TODO: load all files from a directory, similar with ufw, to make it easier for automated install scripts
# Ideally we should generate ufw (and similar) configs as well, in case user already has an iptables solution.

PROXY_PORT=${ENVOY_PORT:-15001}


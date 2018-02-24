#!/bin/bash


KERNEL_VERSION=$(uname -r)
#KERNEL_VERSION2=$(cat /proc/version)
HOSTNAME=`hostname`
GPU_INFO=$(lspci | grep -i nvidia)

# https://stackoverflow.com/questions/16553089/dynamic-variable-names-in-bash
declare -A magic_variable=()

# https://superuser.com/questions/284187/bash-iterating-over-lines-in-a-variable
# parse yum info version info from various packages,
# gcc, glibc, docker-ce, kernel-devel, kernel-headers where the repo shows installed - or find a better way to do this..
# maybe in SALT, we can set grains with that info?

function getVersion() {
  _yumOutput=$(yum info $1)
#  echo "yum output: $_yumOutput"
  # _yumOutput now contains a string of many lines.  Search for "Version".  When we seee "Repo : installed" we're done.
  while read -r line; do
#    echo "reading line: $line"
    if [[ $line = *"Version"* ]]; then
#	echo "found version: $line"
	magic_variable[$2]=$(cut -d ":" -f 2 <<< "$line")
    fi
    if [[ $line = *"installed"* ]]; then
      break
    fi
  done <<< "$_yumOutput"
}

getVersion "kernel-devel" "KERNEL_DEVEL_VERSION"
getVersion "kernel-headers" "KERNEL_HEADERS_VERSION"
getVersion "gcc" "GCC_VERSION"
getVersion "glibc" "GLIBC_VERSION"
getVersion "docker-ce" "DOCKER_VERSION"
getVersion "dkms" "DKMS_VERSION"
getVersion "libstdc++.i686" "LIBSTDC_VERSION"

echo "hostname: $HOSTNAME"
echo "kernel: $KERNEL_VERSION"
echo "gpu: $GPU_VERSION"

for i in "${!magic_variable[@]}"
do
  echo "$i: ${magic_variable[$i]}"
done

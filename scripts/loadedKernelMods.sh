#!/bin/sh
cut -f1 -d" " /proc/modules
echo -----
version=`cut -f1 -d" " /proc/sys/kernel/osrelease`
echo $version
echo -----
cut -f1 -d" " /lib/modules/$version/modules.builtin

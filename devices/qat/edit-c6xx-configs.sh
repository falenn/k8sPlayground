setenforce 0
swapoff -a
sed -i 's/\[SSL\]/\[SHIM\]/g' /etc/c6xx*
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
rmmod usdm_drv
insmod ./QAT/build/usdm_drv.ko max_huge_pages=1024

cd /root
tar xvof /root/dpdk-18.08.tar.xz
# compile with 15
# load igb_uio driver with 18
# exit with 35
printf "15\n\n18\n\n35\n" | /root/dpdk-18.08/usertools/dpdk-setup.sh

systemctl restart docker
service qat_service restart


service qat_service start
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
#echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
#rmmod usdm_drv
#insmod ./QAT/build/usdm_drv.ko max_huge_pages=1024 max_huge_pages_per_process=16

cd /root
tar xvof /root/dpdk-18.08.tar.xz
# compile with 15
# load igb_uio driver with 18
# exit with 35
printf "15\n\n18\n\n35\n" | /root/dpdk-18.08/usertools/dpdk-setup.sh


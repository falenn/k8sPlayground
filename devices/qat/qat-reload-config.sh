service qat_service stop
service qat_service shutdown
for x in {0..47};do cp -f /root/k8sPlayground/devices/qat/c6xx_dev0.conf.example /etc/c6xxvf_dev${x}.conf;done
service qat_service start
systemctl start qat_service
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
echo "################################################"
systemctl status qat_service
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
rmmod usdm_drv
insmod ./QAT/build/usdm_drv.ko max_huge_pages=1024 max_huge_pages_per_process=16

cd /root
tar xvof /root/dpdk-18.08.tar.xz
# compile with 15
# load igb_uio driver with 18
# exit with 35
printf "15\n\n18\n\n35\n" | /root/dpdk-18.08/usertools/dpdk-setup.sh


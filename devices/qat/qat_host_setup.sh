# Variable Declaration
MASTER="c0"
WORKER="hpnvme1"

swapoff -a
systemctl restart kubectl

cd /root

# download QAT Drivers
#wget https://01.org/sites/default/files/downloads/intelr-quickassist-technology/qat1.7.l.4.3.0-00033.tar.gz

# create a working directory and untar download
CURDIR=`pwd`
mkdir -p /root/QAT/
cd /root/QAT/
tar xvof ${CURDIR}/qat*.tar.gz

# configure build with sriov support, install drivers if successful
./configure --enable-icp-sriov=host && make && make install && make samples && make samples-install

# sanity checking
lsmod | grep -i qat

# lists all the PF available. found at https://doc.dpdk.org/guides/cryptodevs/qat.html, table 1.6, device C62
# max number of VFs/PF is 16. There are 3 PFs per C62x, which totals 48 VFs per C62x, which means 96 with two cards.

lspci -d:37c8


# lists all the VF available.
lspci -d:37c9
# should total to 96 if using make VFs
lspci -d:37c9 | wc

#systemctl restart qat_service
#systemctl status qat_service
#systemctl enable qat_service
service qat_service shutdown
service qat_service start
# the config files are in /etc/c6*

# Drivers for DPDK igb_uio or uio_pci_generic for VF???
cd /root
tar xvof /root/dpdk-18.08.tar.xz 
# compile with 15
# load igb_uio driver with 18
# exit with 35
printf "15\n\n18\n\n\n\n35\n" | /root/dpdk-18.08/usertools/dpdk-setup.sh
#cd /root/dpdk-18.08/
#make install T=x86_64-native-linuxapp-gcc


echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
rmmod usdm_drv
insmod /root/QAT/build/usdm_drv.ko max_huge_pages=1024 max_huge_pages_per_process=16
#for device in $(seq 1 2); do \
#    for fn in $(seq 0 7); do \
#        echo -n 0000:1a:0${device}.${fn} > \
#        /sys/bus/pci/devices/0000\:1a\:0${device}.${fn}/driver/unbind; \
#
#        echo -n 0000:3d:0${device}.${fn} > \
#        /sys/bus/pci/devices/0000\:3d\:0${device}.${fn}/driver/unbind; \
#
#        echo -n 0000:3f:0${device}.${fn} > \
#        /sys/bus/pci/devices/0000\:3f\:0${device}.${fn}/driver/unbind; \
#    done; \
#done
#cd /root/dpdk-18.08
#modprobe uio
#insmod ./x86_64-native-linuxapp-gcc/kmod/igb_uio.ko
#echo "8086 37c9" > /sys/bus/pci/drivers/igb_uio/new_id
#lspci -vvd:37c9

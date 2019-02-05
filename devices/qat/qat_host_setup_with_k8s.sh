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

systemctl restart qat_service
systemctl status qat_service
systemctl enable qat_service
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
rmmod usdm_drv
insmod /root/QAT/build/usdm_drv.ko max_huge_pages=1024 max_huge_pages_per_process=16
# the config files are in /etc/c6*

# Drivers for DPDK igb_uio or uio_pci_generic for VF???
cd /root
tar xvof /root/dpdk-18.08.tar.xz 
# compile with 15
# load igb_uio driver with 18
# exit with 35
printf "15\n\n18\n\n35\n" | /root/dpdk-18.08/usertools/dpdk-setup.sh

export GOPATH=/

mkdir -p $GOPATH/src/github.com/intel/
cd $GOPATH/src/github.com/intel/ && rm -rf ./*
git clone https://github.com/intel/intel-device-plugins-for-kubernetes.git

cd $GOPATH/src/github.com/intel/intel-device-plugins-for-kubernetes
make  intel-qat-plugin
make qat_plugin

scp $GOPATH/src/github.com/intel/intel-device-plugins-for-kubernetes/deployments/qat_plugin/qat_plugin.yaml ${MASTER}:/root/
scp $GOPATH/src/github.com/intel/intel-device-plugins-for-kubernetes/deployments/qat_plugin/qat_plugin_default_configmap.yaml ${MASTER}:/root/
ssh ${MASTER} "kubectl create -f /root/qat_plugin_default_configmap.yaml"
ssh ${MASTER} "kubectl create -f /root/qat_plugin.yaml"

ssh ${MASTER} "kubectl describe node ${WORKER} | grep qat.intel.com/generic"

cp $GOPATH/src/github.com/intel/intel-device-plugins-for-kubernetes/demo/crypto-perf/Dockerfile /root/dpdk-18.08/

cd /root/dpdk-18.08/
docker build -t crypto-perf .
scp $GOPATH/src/github.com/intel/intel-device-plugins-for-kubernetes/demo/crypto-perf-dpdk-pod-requesting-qat.yaml ${MASTER}:/root/
ssh ${MASTER} "kubectl create -f /root/crypto-perf-dpdk-pod-requesting-qat.yaml"
ssh ${MASTER} "kubectl exec -it dpdkqatuio ./dpdk-test-crypto-perf -- --ptest throughput --devtype crypto_qat --optype cipher-only --cipher-algo aes-cbc --cipher-op  encrypt --cipher-key-sz 16 --total-ops 10000000 --burst-sz 32 --buffer-sz 64"

# attach with a "kubectl exec -it dpdkqatuio bash" on master

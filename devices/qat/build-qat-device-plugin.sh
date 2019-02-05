export GOPATH=/
mkdir -p $GOPATH/src/github.com/intel/
rm -rf $GOPATH/src/github.com/intel/*
cd $GOPATH/src/github.com/intel/
git clone https://github.com/intel/intel-device-plugins-for-kubernetes.git
cd $GOPATH/src/github.com/intel/intel-device-plugins-for-kubernetes
make qat_plugin
make intel-qat-plugin

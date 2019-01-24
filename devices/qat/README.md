! QAT Acceleration of NginX and OpenSSL

!! References

See https://github.com/intel/async_mode_nginx


!! Todo

1. start with Centos 7.2 64x base image ++, Linux 3.10.0-327..
2. enable SR-IOV on hosts
3. add hpnvme2 to the kubernetes clsuter
4. build the following in the Centos7.2 base image
     https://github.com/intel/asynch_mode_nginx
5. confirm that https://github.com/intel/intel-device-plugins-for-kubernetes/blob/master/cmd/qat_plugin/README.md is working


Documentation
https://01.org/sites/default/files/downloads/intelr-quickassist-technology/337020-001qatwcontaineranddocker.pdf

Steps to build docker container:
1. start from centos7.2
2. install QAT driver 4.3.0
3. install openssl 1.1.0h
3. QAT_Engine v0.5.39
4. QATzip v0.2.6

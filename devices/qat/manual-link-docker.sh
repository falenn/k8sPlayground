unset devpara

for dev in `ls /dev/uio*`;do devpara=$devpara" --device="$dev":"$dev; done

export devpara=$devpara" --device=/dev/qat_adf_ctl:/dev/qat_adf_ctl"

export devpara=$devpara" --device=/dev/qat_dev_processes:/dev/qat_dev_processes"

export devpara=$devpara" --device=/dev/usdm_drv:/dev/usdm_drv"

chmod 666 /dev/qat_adf_ctl
chmod 666 /dev/usdm_drv
chmod 666 /dev/qat_dev_processes

#docker run -it --ulimit memlock=16834000:16834000 $devpara --privileged=true meadowgate/qat-centos7:1.0 /bin/bash
docker run -it  --ulimit memlock=-1:-1 --privileged=true -p 443:443 meadowgate/qat-centos7:1.0

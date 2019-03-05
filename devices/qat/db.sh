#!/bin/bash
# Docker buildcycle script
# Build and automate cleanup - good to use on a dev box where this is the
# only project you are workingo on.

REPO_AND_IMAGE='meadowgate/qat-centos7:1.0'
CONTAINER_NAME='qat-centos7'



#stop any running containers
sudo docker ps | grep $CONTAINER_NAME | awk '{print $1}' | xargs docker stop

# remove any existing stopped containers
sudo docker ps -a | grep $CONTAINER_NAME | awk '{print $1}' | xargs docker rm

# remove built image for rebuild
# ßdocker rmi $(docker images | grep -v $REPO_AND_IMAGE | awk {'print $3'})

# remove any images that are left around
# docker rmi $(docker images -f dangling=true -q)

# build the image, removing intermediate layers, deleting cache
# docker build --rm --no-cache -t "$REPO_AND_IMAGE" .
sudo docker build \
    --rm \
    -t "$REPO_AND_IMAGE" .

if [ $? -eq 0 ]; then
  # run the newly built image
  #docker run --name $CONTAINER_NAME -p 25565:25565 -l $CONTAINER_NAME $REPO_AND_IMAGE

  # My kernel information
  # Linux 64cd1417ea3a 4.4.27-boot2docker #1 SMP Tue Oct 25 19:51:49 UTC 2016 x86_64 Linux

  # run in inteactive for debugging / development
 sudo docker run \
        --name $CONTAINER_NAME \
        -l $CONTAINER_NAME \
        --cap-add=NET_ADMIN \
        --device=/dev/net/tun \
        -it \
        --ulimit memlock=-1:-1 \
        --privileged=true \
        -p 443:443 \
	-v $(pwd):/usr/local/nginx/ssl/certs/ \
        $REPO_AND_IMAGE
  #$REPO_AND_IMAGE
        #for debugging
  # follow stdout
  #docker logs -f $CONTAINER_NAME
else
  echo "Failed to build"
fi

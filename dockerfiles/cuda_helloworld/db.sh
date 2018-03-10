#!/bin/bash
# Docker buildcycle script
# Build and automate cleanup - good to use on a dev box where this is the
# only project you are workingo on.

REPO_AND_IMAGE='org.pm/alpine-openvpn:2.1'
CONTAINER_NAME='openvpn'


#stop any running containers
docker ps | grep $CONTAINER_NAME | awk '{print $1}' | xargs docker stop

# remove any existing stopped containers
docker ps -a | grep $CONTAINER_NAME | awk '{print $1}' | xargs docker rm

# remove built image for rebuild
# ßdocker rmi $(docker images | grep -v $REPO_AND_IMAGE | awk {'print $3'})

# remove any images that are left around
# docker rmi $(docker images -f dangling=true -q)

# build the image, removing intermediate layers, deleting cache
# docker build --rm --no-cache -t "$REPO_AND_IMAGE" .
docker build \
    --rm \
    -t "$REPO_AND_IMAGE" .

if [ $? -eq 0 ]; then
  # run the newly built image
  #docker run --name $CONTAINER_NAME -p 25565:25565 -l $CONTAINER_NAME $REPO_AND_IMAGE

  # My kernel information
  # Linux 64cd1417ea3a 4.4.27-boot2docker #1 SMP Tue Oct 25 19:51:49 UTC 2016 x86_64 Linux

  # run in inteactive for debugging / development
  docker run \
        --name $CONTAINER_NAME \
        -v ~/dev/projectMayhem/docker-alpine-openvpn/config:/opt/config \
        -l $CONTAINER_NAME \
        --cap-add=NET_ADMIN \
        --device=/dev/net/tun \
        -it \
        --entrypoint="/bin/bash" \
        $REPO_AND_IMAGE
  #$REPO_AND_IMAGE
        #for debugging


  # attach to the new container
  #docker attach -it minecraft

  # follow stdout
  #docker logs -f $CONTAINER_NAME
else
  echo "Failed to build"
fi

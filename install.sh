#!/usr/bin/env sh

# install docker
curl -sSL https://get.docker.com | sh


# Delete all previously containers
sudo docker rm $(sudo docker ps -a -q) -f
# Delete previously containers images
sudo docker rmi $(sudo docker images -q) -f


# 1000 - Portainer
# 1001 - cAdvisor
# 1002 - Node-Red
# 1003 - Swagger Editor

# Deploy Portainer for easiest container management
sudo docker run -d -p 1000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# Deploy Node-Red
sudo docker run -d -p 1002:1880 --network="thingsboard-docker_default" --restart=always --name Node-Red nodered/node-red-docker

# Deploy Swagger Editor
sudo docker run -d -p 1003:8080 --network="thingsboard-docker_default" --restart=always swaggerapi/swagger-editor

#Deploy cAdvisor for monitoring resources
sudo docker run \
 --volume=/:/rootfs:ro \
 --volume=/var/run:/var/run:rw \
 --volume=/sys:/sys:ro \
 --volume=/var/lib/docker/:/var/lib/docker:ro \
 --volume=/dev/disk/:/dev/disk:ro \
 --publish=1001:8080 \
 --detach=true \
 --restart=always \
 --name=cadvisor \
 google/cadvisor:latest

# Deploy Home Assistance
sudo docker run -d --name="home-assistant" \
  -v /path/to/your/config:/config \
  -v /etc/localtime:/etc/localtime:ro --net=host homeassistant/raspberrypi3-homeassistant

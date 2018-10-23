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
# 2000 - Home Assistant

# Deploy Portainer for easiest container management
sudo docker run -d -p 1000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

#Deploy cAdvisor for monitoring resources
sudo docker run -d -p 1001:8080 --restart=always google/cadvisor

# Deploy Node-Red
#sudo docker run -d -p 1002:1880 --restart=always --name Node-Red nodered/node-red-docker

# Deploy Swagger Editor
#sudo docker run -d -p 1003:8080 --restart=always swaggerapi/swagger-editor

# Deploy Home Assistance
# sudo docker run -d -p 2000:8123 homeassistant/raspberrypi3-homeassistant
 sudo curl -sL https://raw.githubusercontent.com/home-assistant/hassio-build/master/install/hassio_install | sudo bash -s -- -m raspberrypi3

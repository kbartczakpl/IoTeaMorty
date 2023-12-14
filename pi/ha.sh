#!/bin/bash

readonly NAME="homeassistant"
readonly IMAGE="homeassistant/raspberrypi4-homeassistant:stable"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e PUID=1000 -e PGID=1000 \
  -e TZ=Europe/London \
  -p 8123:8123 \
  -p 1883:1883 \
  -v /media/docker/${NAME}/config:/config \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

#!/bin/bash

readonly NAME="jackett"
readonly IMAGE="linuxserver/jackett"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e TZ=Europe/London \
  -e VIRTUAL_PORT=9117 \
  -e PUID=1000 -e PGID=1000 \
  -e TZ=Europe/London \
  -p 9117:9117 \
  -v /media/docker/${NAME}/config:/config \
  -v /media/transmission/downloads/:/downloads \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}
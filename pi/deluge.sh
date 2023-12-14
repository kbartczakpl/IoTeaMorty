#!/bin/bash

readonly NAME="deluge"
readonly IMAGE="lscr.io/linuxserver/deluge"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 8112:8112 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -v /media/docker/${NAME}/config:/config \
  -v /media/downloads/:/downloads \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

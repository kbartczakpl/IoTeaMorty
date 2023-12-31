#!/bin/bash

readonly NAME="transmission"
readonly IMAGE="linuxserver/transmission"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e TRANSMISSION_WEB_HOME=/combustion-release/ `#optional` \
  -e USER=hi  \
  -e PASS=qweqwe  \
  -p 8091:9091 \
  -p 51414:51413 \
  -p 51414:51413/udp \
  -v /media/docker/${NAME}/:/config \
  -v /media/docker/${NAME}/tmp/:/transmission-web-control/tmp/transmission \
  -v /media/${NAME}/downloads/:/downloads \
  -v /media/${NAME}/watch/:/watch \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

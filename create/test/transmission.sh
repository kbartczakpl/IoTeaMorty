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
  -v /home/docker/storage/${NAME}/:/config \
  -v /data/transmission-incomplete/:/downloads \
  -v /data/transmission-watch/:/watch \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

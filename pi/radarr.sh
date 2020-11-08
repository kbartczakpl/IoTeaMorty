#!/bin/bash

readonly NAME="radarr"
readonly IMAGE="linuxserver/radarr"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e TZ=Europe/London \
  -e VIRTUAL_PORT=7878 \
  -e PUID=1000 -e PGID=1000 \
  -e TZ=Europe/London \
  -p 7878:7878 \
  -v /media/docker/${NAME}/config:/config \
  -v /media/tv/movies:/movies \
  -v /media/tv//movies-animation:/movies-animation \
  -v /media/transmission/downloads/:/downloads \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}
#!/bin/bash

readonly NAME="sonarr"
readonly IMAGE="linuxserver/sonarr"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e TZ=Europe/London \
  -e VIRTUAL_PORT=8989 \
  -e PUID=1000 -e PGID=1000 \
  -e TZ=Europe/London \
  -p 9989:8989 \
  -v /media/docker/${NAME}/config:/config \
  -v /media/tv/tvSeries:/tv \
  -v /media/transmission/downloads/:/downloads \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}
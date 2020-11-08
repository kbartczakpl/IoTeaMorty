#!/bin/bash

readonly NAME="domoticz"
readonly IMAGE="linuxserver/domoticz"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e PUID=1000 -e PGID=1000 \
  -e TZ=Europe/London \
  -p 9180:8080 \
  -p 6144:6144 \
  -p 1443:1443 \
  -v /media/docker/${NAME}/config:/config \
  --restart unless-stopped \
  ${IMAGE}:stable

docker start ${NAME}

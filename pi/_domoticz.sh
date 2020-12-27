#!/bin/bash

readonly NAME="mkdomoticz"
readonly IMAGE="joshuacox/mkdomoticz:arm"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e PUID=1000 -e PGID=1000 \
  -e TZ=Europe/London \
  -p 9181:8080 \
  -p 1884:1883 \
  -v /media/docker/${NAME}/config:/config \
  -v /media/docker/${NAME}/plugins:/src/domoticz/plugins \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

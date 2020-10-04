#!/bin/bash

readonly NAME="jellyfin"
readonly IMAGE="linuxserver/jellyfin"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -e TZ=Europe/London \
  -e VIRTUAL_PORT=8096 \
  -p 9096:8096 \
  -v /media/docker/${HOST}:/config \
  -v /media/:/media/ \
  --device=/dev/vcsm:/dev/vcsm \
  --device=/dev/vchiq:/dev/vchiq \
  -v /opt/vc/lib:/opt/vc/lib \
  --device=/dev/video10:/dev/video10 \
  --device=/dev/video11:/dev/video11 \
  --device=/dev/video12:/dev/video12 \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

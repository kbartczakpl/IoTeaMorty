#!/bin/bash

readonly HOST="dticz.bartczak.eu"
readonly NAME="domoticz"

docker create \
  --name=${NAME} \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 9090:8080 \
  -p 6144:6144 \
  -p 1443:1443 \
  -p 1883:1883 \
  -v /home/docker/storage/${NAME}/config:/config \
  --restart unless-stopped \
  linuxserver/domoticz

docker start ${NAME}

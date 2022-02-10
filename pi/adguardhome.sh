#!/bin/bash

readonly NAME="adguard"
readonly IMAGE="adguard/adguardhome"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -v /media/docker/${NAME}/workdir:/opt/adguardhome/work \
  -v /media/docker/${NAME}/confdir:/opt/adguardhome/conf \
  -p 153:53/tcp -p 153:53/udp \
  -p 78:80/tcp -p 3000:3000/tcp \
  -p 67:67/udp -p 58:68/tcp -p 58:68/udp \
  -p 343:443/tcp \
  -p 853:853/tcp \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

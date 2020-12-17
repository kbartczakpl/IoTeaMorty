#!/bin/bash

readonly NAME="samba"
readonly IMAGE="dperson/samba"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
  --name=${NAME} \
  -p 139:139 -p 445:445 \
  -v /media:/mount \
  --restart unless-stopped \
  ${IMAGE} -p

docker start ${NAME}

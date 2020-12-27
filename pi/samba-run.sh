#!/bin/bash

readonly NAME="samba"
readonly IMAGE="dperson/samba"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker run -it \
  --name=${NAME} \
  -p 139:139 -p 445:445 \
  -v /media/transmission/watch:/mount/watch \
  -v /media/transmission/downloads:/mount/downloads \
  --restart unless-stopped \
  -d ${IMAGE} -p \
  -u "hi;qweqwe" \
  -s "download;/mount/downloads"\
  -s "download-watch;/mount/watch"

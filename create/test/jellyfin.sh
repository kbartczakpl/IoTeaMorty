#!/bin/bash

readonly HOST="jellyfin.bartczak.eu"
readonly NAME="jellyfin"
readonly IMAGE="linuxserver/jellyfin"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   -e PUID=1000 \
   -e PGID=1000 \
   --expose 80 \
  -e TZ=Europe/London \
  -p 8896:8096 \
  -v /home/docker/storage/${HOST}:/config \
   -v /mnt/disk2/tvSeries-animation/:/media/tv-anim/ \
   -v /mnt/disk2/movies-animation/:/media/mov-anim/ \
   -v /mnt/disk2/tvSeries/:/media//tv/ \
   -v /mnt/disk2/movies/:/media/mov/ \
  --restart unless-stopped \
  ${IMAGE}

docker start ${NAME}

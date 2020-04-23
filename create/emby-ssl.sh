#!/bin/bash

readonly HOST="emby.bartczak.eu"
readonly NAME="emby"

docker create \
   --name=${NAME} \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   --network=default \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   -e TZ="UTC +2" \
   --expose 80 \
   -e VIRTUAL_PORT=8096 \
   -p 8096:8096 -p 8920:8920 \
   -v /home/docker/storage/emby/:/config/ \
   -v /mnt/disk2/tvSeries-animation/:/media/tv-anim/ \
   -v /mnt/disk2/movies-animation/:/media/mov-anim/ \
   -v /mnt/disk2/tvSeries/:/media//tv/ \
   -v /mnt/disk2/movies/:/media/mov/ \
   -v /data/media/familyEvents/:/media/familyEvents \
   emby/embyserver:4.1.0.26

docker start ${NAME}

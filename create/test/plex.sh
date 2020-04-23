#!/bin/bash

readonly HOST="plex.bartczak.eu"
readonly NAME="plex"

docker create \
   --name=${NAME} \
   --net=host \
   -e VERSION=latest \
   -e PUID=1000 -e PGID=1000 \
   -e TZ=Europe/London \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   -v /home/docker/storage/plex/config/:/config \
   -v /data/media/tvSeries:/data/tvshows \
   -v /data/media/tvSeries-animation:/data/tvshows-anim \
   -v /data/media/movies/:/data/movies \
   -v /data/media/movies-animation/:/data/movies-animation \
   -v /home/docker/storage/plex/transcode:/transcode \
   linuxserver/plex



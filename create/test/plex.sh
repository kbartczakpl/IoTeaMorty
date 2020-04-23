#!/bin/bash

docker create \
   --name=plex \
   --net=host \
   -e VERSION=latest \
   -e PUID=1000 -e PGID=1000 \
   -e TZ=Europe/London \
   -v /home/docker/storage/plex/config/:/config \
   -v /data/media/tvSeries:/data/tvshows \
   -v /data/media/tvSeries-animation:/data/tvshows-anim \
   -v /data/media/movies/:/data/movies \
   -v /data/media/movies-animation/:/data/movies-animation \
   -v /home/docker/storage/plex/transcode:/transcode \
   linuxserver/plex



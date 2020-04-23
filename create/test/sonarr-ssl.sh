#!/bin/bash

docker create \
   --name=sonarr \
    -p 8989:8989 \
    -e PUID=1000 -e PGID=1000 \
    -v /dev/rtc:/dev/rtc:ro \
    -v /home/docker/storage/sonarr/config:/config \
    -v /data/media/tvSeries:/data/media/tvSeries \
    -v /data/media/tvSeries-anim:/data/media/tvSeries-anim \
    -v /data/transmission-incomplete:/downloads \
    linuxserver/sonarr

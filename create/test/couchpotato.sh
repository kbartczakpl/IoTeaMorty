#!/bin/bash

docker create \
   --name=couchpotato \
    -p 5050:5050 \
    -e PUID=1000 -e PGID=1000 \
    -e TZ=Europe/London \
    -v /dev/rtc:/dev/rtc:ro \
    -v /home/docker/storage/couchpotato/config:/config \
    -v /data/media/movies:/data/media/movies \
    -v /data/media/movies-anim:/data/media/movies-anim \
    -v /data/transmission-incomplete:/downloads \
    linuxserver/couchpotato

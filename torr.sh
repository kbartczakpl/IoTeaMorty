#!/bin/bash

docker stop fget
docker rm fget

docker create \
    --name=fget \
    -p 5050:5050 \
    -v $(pwd)/fget/data:/data \
    -v $(pwd)/fget/config:/config \
    -e FG_WEBUI_PASSWD=qweqwe \
    -e FG_LOG_LEVEL=info \
    -e FG_LOG_FILE=flexget.log \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    wiserain/flexget

docker start fget

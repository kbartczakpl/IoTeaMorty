#!/bin/bash

readonly NAME="mariadb"
readonly IMAGE="lscr.io/linuxserver/mariadb"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e PUID=1000 \
   -e PGID=1000 \
   -e MYSQL_ROOT_PASSWORD_FILE=/secrets/mariadb/root_password \
   -v $(pwd)/run/secrets:/secrets \
   -e TZ=Europe/London \
   -v /media/docker/${NAME}:/config \
   -p 3306:3306 \
   --restart unless-stopped \
   ${IMAGE}

docker start ${NAME}

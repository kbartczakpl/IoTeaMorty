#!/bin/bash

readonly NAME="mariadb"
readonly IMAGE="mariadb:latest"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD_FILE=/tmp/root_password \
   -v $(pwd)/run/secrets/${NAME}/root_password:/tmp/root_password \
   -v /media/docker/${NAME}:/var/lib/mysql \
   -p 3306:3306 \
   --restart unless-stopped \
   ${IMAGE}

docker start ${NAME}

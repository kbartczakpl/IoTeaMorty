#!/bin/bash

readonly NAME="mariadb"
readonly IMAGE="mariadb:latest"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD=/run/secrets/${NAME}/root_password \
   -v /media/docker/storage/${NAME}:/var/lib/mysql \
   ${IMAGE}

docker start ${NAME}

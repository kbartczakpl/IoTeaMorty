#!/bin/bash

readonly NAME="mariadb"
readonly IMAGE="mariadb:latest"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD=/run/secrets/${NAME}/root_password \
   -e MYSQL_USER=/run/secrets/${NAME}/root_user \
   -v /media/docker/storage/${NAME}:/var/lib/mysql \
   ${IMAGE}

docker start ${NAME}

#!/bin/bash

readonly NAME="mysql"
readonly IMAGE="mysql:latest"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD=/run/secrets/MYSQL_ROOT_PASSWORD \
   -e MYSQL_USER=/run/secrets/MYSQL_USER \
   -d ${IMAGE}

docker start ${NAME}


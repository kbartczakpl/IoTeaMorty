#!/bin/bash

readonly NAME="mysql"
readonly IMAGE="mysql:8.0.21"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD=/run/secrets/MYSQL_ROOT_PASSWORD \
   -e MYSQL_USER=/run/secrets/MYSQL_USER \
   mysql:latest

docker start ${NAME}


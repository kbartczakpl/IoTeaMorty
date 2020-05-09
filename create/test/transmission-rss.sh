#!/bin/bash

readonly NAME="transmission-rss"
readonly IMAGE="nning2/transmission-rss"

# docker pull ${IMAGE}

# docker stop ${NAME}
# docker rm ${NAME}

docker create \
  --name=${NAME} \
  -v /home/docker/storage/${NAME}/transmission-rss.conf:/etc/transmission-rss.conf \
  -v /home/docker/storage/${NAME}/log:/var/log \
  -v /home/docker/storage/${NAME}/.config:/home/ruby/.config \
  ${IMAGE}

# docker start ${NAME}


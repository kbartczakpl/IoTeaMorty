#!/bin/bash

readonly VOLUMES="-v $(pwd)/storage/certs:/etc/nginx/certs:rw "
readonly EXTRAS="--volumes-from nginx-reverse-proxy --network=default"
readonly ENVS="-e ACME_TOS_HASH=cc88d8d9517f490191401e7b54e9ffd12a2b9082ec7a1d4cec6101f9f1647e7b" # Can change from time-to-time...

docker run -d ${ENVS} ${EXTRAS} ${VOLUMES} -v /var/run/docker.sock:/var/run/docker.sock:rw --name nginx-letsencrypt jrcs/letsencrypt-nginx-proxy-companion

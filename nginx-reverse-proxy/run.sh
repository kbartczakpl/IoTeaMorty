#!/bin/bash

docker stop nginx-reverse-proxy
docker rm nginx-reverse-proxy


readonly VOLUMES="-v $(pwd)/storage/certs:/etc/nginx/certs:ro \
	-v /etc/nginx/vhost.d \
	-v $(pwd)/storage/custom.conf:/etc/nginx/conf.d/custom.conf:ro \
	-v $(pwd)/storage/security.conf:/etc/nginx/conf.d/security.conf:ro \
	-v $(pwd)/storage/html:/usr/share/nginx/html \
	-v $(pwd)/storage/nginx.tmpl:/app/nginx.tmpl:ro "

readonly EXTRAS="--label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy --network=bridge"

docker run -d -p 0.0.0.0:80:80 -p 0.0.0.0:443:443 ${EXTRAS} ${VOLUMES} -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginx-reverse-proxy jwilder/nginx-proxy:alpine

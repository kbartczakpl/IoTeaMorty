#!/bin/bash

docker create --name proxy -p 80:80 -p 443:443  -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy

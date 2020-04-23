#!/bin/bash

docker create \
   --name=kodi \
   -e VIRTUAL_HOST=kodi.bartczak.eu \
   -e TZ="UTC +2" \
   -v /home/docker/storage/kodi/:/config/.kodi \
   linuxserver/kodi-headless


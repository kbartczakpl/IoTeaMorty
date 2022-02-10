#!/bin/bash

curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh\

sudo bash installer.sh \
    --machine raspberrypi4-64 \
    --sysconfdir /media/docker/ha/config

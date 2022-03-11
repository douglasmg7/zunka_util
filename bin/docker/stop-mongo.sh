#!/usr/bin/env bash

# Start docker services.
[[ `systemctl status docker | awk '/Active/{print $2}'` == inactive ]] && echo "Starting docker..." && sudo systemctl start docker
sleep .5

docker stop zunka_mongo

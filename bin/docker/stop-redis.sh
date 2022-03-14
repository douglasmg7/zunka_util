#!/usr/bin/env bash

# Start docker service.
[[ `systemctl status docker | awk '/Active/{print $2}'` == inactive ]] && echo "Starting docker..." && sudo systemctl start docker && sleep .5

echo "Stopping dockerized zunka_redis..."
[[ $(docker ps | grep zunka_redis) ]] && docker stop zunka_redis &> /dev/null

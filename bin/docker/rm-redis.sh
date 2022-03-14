#!/usr/bin/env bash

# Start docker service.
[[ `systemctl status docker | awk '/Active/{print $2}'` == inactive ]] && echo "Starting docker..." && sudo systemctl start docker && sleep .5

echo "Removing dockerized zunka_redis..."
[[ $(docker ps | grep zunka_redis) ]] && docker stop zunka_redis &> /dev/null
if [[ $(docker ps -a | grep zunka_redis) ]]
then
    docker rm zunka_redis &> /dev/null
    # docker volume rm zunka_redis_volume &> /dev/null
fi

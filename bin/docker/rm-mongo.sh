#!/usr/bin/env bash

# Start docker service.
[[ `systemctl status docker | awk '/Active/{print $2}'` == inactive ]] && echo "Starting docker..." && sudo systemctl start docker && sleep .5

echo "Removing dockerized zunka_mongo..."
[[ $(docker ps | grep zunka_mongo) ]] && docker stop zunka_mongo &> /dev/null
if [[ $(docker ps -a | grep zunka_mongo) ]]
then
    docker rm zunka_mongo &> /dev/null
    docker volume rm zunka_mongo_volume &> /dev/null
fi

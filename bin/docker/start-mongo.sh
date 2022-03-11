#!/usr/bin/env bash

# # Must run in the current shell enviromnent.
# [[ $0 != -bash ]] && echo Usage: . $BASH_SOURCE && exit 1

# Start docker services.
[[ `systemctl status docker | awk '/Active/{print $2}'` == inactive ]] && echo "Starting docker..." && sudo systemctl start docker
sleep .5

# Create or start mongo container.
if [[ -z $(docker ps -a | grep zunka_mongo) ]]
# Create and implicit start container.
then
    echo 'Creating and starting zunka_mongo container...'
    docker run -d --name zunka_mongo -v zunka_mongo_volume:/data/db -p 27017:27017 mongo:3.6.3
    echo '!!! No data, import backup to new created mongo docker'
# Start zunka_mongo container.
else
    [[ -z $(docker ps | grep zunka_mongo) ]] && echo 'Starting zunka_mongo container...' && docker start zunka_mongo &>/dev/null
fi

echo "To access mongo:"
echo "  docker exec -it zunka_mongo bash"
echo "  mongo zunka"
echo

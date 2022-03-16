#!/usr/bin/env bash

# # Must run in the current shell enviromnent.
# [[ $0 != -bash ]] && echo Usage: . $BASH_SOURCE && exit 1

# zunkapath not defined.
[[ -z "$MONGODB_ADMIN_USER" ]] && printf "Error: MONGODB_ADMIN_USER not defined.\n" >&2 && exit 1 
[[ -z "$MONGODB_ADMIN_PASSWORD" ]] && printf "Error: MONGODB_ADMIN_PASSWORD not defined.\n" >&2 && exit 1 
[[ -z "$MONGODB_APP_USER" ]] && printf "Error: MONGODB_APP_USER not defined.\n" >&2 && exit 1 
[[ -z "$MONGODB_APP_PASSWORD" ]] && printf "Error: MONGODB_APP_PASSWORD not defined.\n" >&2 && exit 1 

# Start docker services.
[[ `systemctl status docker | awk '/Active/{print $2}'` == inactive ]] && echo "Starting docker..." && sudo systemctl start docker
sleep .5

# Create or start mongo container.
if [[ -z $(docker ps -a | grep zunka_mongo) ]]
# Create and implicit start container.
then
    echo 'Creating and starting zunka_mongo container...'
    # docker run -d --name zunka_mongo -v zunka_mongo_volume:/data/db -p 27017:27017 mongo:3.6.3
    docker run -d --name zunka_mongo -v zunka_mongo_volume:/data/db -p 27017:27017 \
        -e MONGO_INITDB_ROOT_USERNAME=$MONGODB_ADMIN_USER \
        -e MONGO_INITDB_ROOT_PASSWORD=$MONGODB_ADMIN_PASSWORD \
        mongo:3.6.3
    # Create user app.
    echo 'Creating user app...'
    sleep 3
    docker exec -it zunka_mongo bash -c \
    "mongo -u $MONGODB_ADMIN_USER --authenticationDatabase admin -p $MONGODB_ADMIN_PASSWORD admin <<EOF
db.createUser({user: '$MONGODB_APP_USER', pwd: '$MONGODB_APP_PASSWORD', roles: [{role: 'readWrite', db: 'zunka'}]});
EOF"

    echo '!!! No data, import backup to new created mongo docker'
    SHOW_DOCKER_MONGO_TIP='True'
# Start zunka_mongo container.
else
    [[ -z $(docker ps | grep zunka_mongo) ]] && echo 'Starting zunka_mongo container...' && docker start zunka_mongo &>/dev/null && SHOW_DOCKER_MONGO_TIP='True'
fi

if [[ $SHOW_DOCKER_MONGO_TIP ]]
then
    echo "To access mongo:"
    echo "  docker exec -it zunka_mongo bash"
    echo "  mongo -u admin --authenticationDatabase admin -p"
    echo "  mongo zunka -u app --authenticationDatabase admin -p"
fi

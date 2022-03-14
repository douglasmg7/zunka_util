#!/usr/bin/env bash

# Needed envs.
[[ -z "$ZUNKAPATH_DATA" ]] && printf "Error: ZUNKAPATH_DATA enviorment not defined.\n" >&2 && exit 1 
DATA_PATH=$ZUNKAPATH_DATA/redis_data

# # Create path to data if not exist.
# if [ ! -d "$DATA_PATH" ]; then
  # # Control will enter here if $DIRECTORY doesn't exist.
# fi


# Create or start redis container.
if [[ -z $(docker ps -a | grep zunka_redis) ]]
# Create and implicit start container.
then
    echo 'Creating and starting zunka_redis container...'
    # docker run -d --name zunka_redis -p 6379:6379 -v "/home/douglasmg7/b:/var/lib/redis/" redis:4.0.9 redis-server --save 60 1 --loglevel warning
    # docker run -d --name zunka_redis -p 6379:6379 -v "/home/douglasmg7/a:/data" -v "/home/douglasmg7/b:/var/lib/redis/" redis:4.0.9 redis-server --save 60 1
    # docker run -d --name zunka_redis -p 6379:6379 -v "/home/douglasmg7/a:/data"  redis:4.0.9 redis-server --save 60 1 --loglevel warning
    docker run -d --name zunka_redis -p 6379:6379 -v $DATA_PATH  redis:4.0.9 redis-server --save 60 1 --loglevel warning
    echo '!!! No data, import backup to new created redis docker'

# Start zunka_redis container.
else
    [[ -z $(docker ps | grep zunka_redis) ]] && echo 'Starting zunka_redis container...' && docker start zunka_redis &>/dev/null

fi

echo "To access redis:"
echo "  docker exec -it zunka_redis sh"
echo "  redis-cli"
echo

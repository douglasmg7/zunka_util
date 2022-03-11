#!/usr/bin/env bash

# Must run in the current shell enviromnent.
[[ $0 != -bash ]] && echo Usage: . $BASH_SOURCE && exit 1

# Create or start redis container.
if [[ -z $(docker ps -a | grep zunka_redis) ]]
# Create and implicit start container.
then
    echo 'Creating and starting zunka_redis container...'
    # docker run -d --name zunka_redis -p 6379:6379 -v "/home/douglasmg7/b:/var/lib/redis/" redis:4.0.9 redis-server --save 60 1 --loglevel warning
    # docker run -d --name zunka_redis -p 6379:6379 -v "/home/douglasmg7/a:/data" -v "/home/douglasmg7/b:/var/lib/redis/" redis:4.0.9 redis-server --save 60 1
    docker run -d --name zunka_redis -p 6379:6379 -v "/home/douglasmg7/a:/data"  redis:4.0.9 redis-server --save 60 1 --loglevel warning
--loglevel warning
    echo '!!! No data, import backup to new created redis docker'

# Start zunka_redis container.
else
    [[ -z $(docker ps | grep zunka_redis) ]] && echo 'Starting zunka_redis container...' && docker start zunka_redis &>/dev/null

fi

echo "To access redis:"
echo "  docker exec -it zunka_redis sh"
echo "  redis-cli"
echo

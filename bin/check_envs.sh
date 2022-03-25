#!/usr/bin/env bash

ERR=0
for env in $@
do
    [[ -z ${!env} ]] && printf "Error: env $env not defined.\n" >&2 && ERR=1 
    # echo ${!env}
done

[[ $ERR != 0 ]] && exit

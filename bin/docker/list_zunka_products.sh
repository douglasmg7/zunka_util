#!/usr/bin/env bash

# docker exec -it zunka_mongo bash -c \
# "mongo -u $MONGODB_APP_USER --authenticationDatabase admin -p $MONGODB_APP_PASSWORD zunka <<EOF
# db.products.find({}).limit(10).pretty();
# EOF"

# docker exec -it zunka_mongo bash -c \
# "mongo -u $MONGODB_APP_USER --authenticationDatabase admin -p $MONGODB_APP_PASSWORD zunka <<EOF
# db.products.find({}).limit(10).pretty().count();
# EOF"

# docker exec -it zunka_mongo bash -c \
# "mongo -u $MONGODB_APP_USER --authenticationDatabase admin -p $MONGODB_APP_PASSWORD zunka --eval 'db.products.find({}).limit(10).pretty().count()'; ls"

docker exec -it zunka_mongo bash -c \
"mongo -u $MONGODB_APP_USER --authenticationDatabase admin -p $MONGODB_APP_PASSWORD zunka --eval 'db.products.find({}).limit(10).pretty()'"

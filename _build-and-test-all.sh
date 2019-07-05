#! /bin/bash

set -e

docker-compose -f docker-compose-${DATABASE}-${MODE}.yml down -v

docker-compose  -f docker-compose-${DATABASE}-${MODE}.yml up -d ${DATABASE} zookeeper ${BROKER}

./wait-for-${DATABASE}.sh

docker-compose  -f docker-compose-${DATABASE}-${MODE}.yml up -d cdcservice
./wait-for-services.sh $DOCKER_HOST_IP 8099
./gradlew :eventuate-tram-examples-jdbc-${BROKER}:cleanTest :eventuate-tram-examples-jdbc-${BROKER}:test

docker-compose -f docker-compose-${DATABASE}-${MODE}.yml down -v

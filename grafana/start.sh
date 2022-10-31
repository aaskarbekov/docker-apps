#!/bin/bash
# Author: Askarbekov Aris
# Description: This script starts deploy and makes some customizations

IMAGE_VERSION=$1
CONFIG_DIR=config
DATA_DIR=data
LOGS_DIR=logs
TEMP_CONTAINER=temp_container
echo "Creating directories to store Grafana configs, data and logs."
sleep 3
mkdir -p ${CONFIG_DIR} ${DATA_DIR} ${LOGS_DIR}
echo "Done."

echo "Checking the docker image version supplied. If version did not provided, it will be the 'latest'. Further application container will be based on that selected image."
sleep 3
test -z $1 && IMAGE_VERSION=latest

echo "Running temporary container to obtain configuration files."
sleep 3
docker run -d --name ${TEMP_CONTAINER} grafana/grafana:${IMAGE_VERSION}
test $? -ne 0 && \
echo "Failed to run temporary container." && \
exit 1 || \
echo "Created temporary container ${TEMP_CONTAINER}."
echo "Done."

echo "Copying configuration files."
sleep 3
docker cp ${TEMP_CONTAINER}:/etc/grafana/. ./${CONFIG_DIR}
test $? -ne 0 && \
docker rm -f ${TEMP_CONTAINER} && \
echo "Failed to copy configuration files from container. ${TEMP_CONTAINER} has been removed" && \
exit 1 || echo "Copy completed."
echo "Done."

echo "Temporary container ${TEMP_CONTAINER} is going to be removed."
sleep 3
docker rm -f ${TEMP_CONTAINER}
test $? -ne 0 && echo "Failed to remove container ${TEMP_CONTAINER}." && \
exit 1 || echo "Removal of container ${TEMP_CONTAINER} completed."
echo "Done"

echo "Application will be started using docker-compose."
sleep 3
export IMAGE_VERSION
docker compose up -d
test $? -ne 0 && \
echo "Failed to run application." && \
exit 1 || echo "Application started."
echo "Done."

echo ""
sleep 3
echo "Grafana is available via http://<ip-address>:3000."
echo "Default username: admin, default password: admin."

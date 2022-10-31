#!/bin/bash

# Author: Askarbekov Aris
# Description:

APPLICATION_NAME=$1

test -z $1 && read -r -p "Please, enter the application name you would like to deploy: " APPLICATION_NAME
sleep 5

echo "You are going to deploy $APPLICATION_NAME."
sleep 1

echo "Checking whether application deployment catalog exists or not."
sleep 5
DEPLOY_EXISTS=`find . -type d -name $APPLICATION_NAME | wc -l`
test ${DEPLOY_EXISTS} -eq 0 && echo "Specified application does not exists in the list of deployment catalogs." && exit 1 
echo "Application deployment catalog found. Check completed."
echo "Done."
sleep 1

echo "Moving to the $APPLICATION_NAME deployment catalog."
sleep 5
cd ./$APPLICATION_NAME
echo "PWD: $PWD"
echo "Done."
sleep 1
	
echo "Executing deployment start script."
sleep 5
./start.sh
test $? -ne 0 && echo "$0: Failed to start deploying $APPLICATION_NAME." 

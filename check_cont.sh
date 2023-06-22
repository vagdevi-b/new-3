#!/bin/bash

CONTAINER_NAMES=("nginx-cont" "mysql_cont")

# Iterate over container names
for CONTAINER_NAME in "${CONTAINER_NAMES[@]}"
do
  # Get the container's status
  STATUS=$(docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME 2>/dev/null)
  # Check if the container is running
  if [ "$STATUS" = "running" ]; then
    echo "Container $CONTAINER_NAME is up and running."
    
    # Check MySQL ping if it is the MySQL container
    if [ "$CONTAINER_NAME" = "mysql_cont" ]; then
      echo "Checking MySQL ping..."
      docker-compose exec mysql mysqladmin ping -h localhost -u root -p

      # Check the exit code of the previous command
      if [ $? -eq 0 ]; then
        echo "MySQL ping successful."
      else
        echo "MySQL ping failed."
        exit 1
      fi
    fi
  else
    echo "Container $CONTAINER_NAME is not running."
    exit 1
  fi
done 

exit 0

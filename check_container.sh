#!/bin/bash

CONTAINER_NAMES=("task-3-nginx-1" "task-3-mysql-1")

# Iterate over container names
for CONTAINER_NAME in "${CONTAINER_NAMES[@]}"
do
  # Get the container's status
  STATUS=$(docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME 2>/dev/null)

  # Check if the container is running
  if [ "$STATUS" = "running" ]; then
    echo "Container $CONTAINER_NAME is up and running."

    # Check MySQL ping if it is the MySQL container
    if [ "$CONTAINER_NAME" = "task-3-mysql-1" ]; then
      echo "Checking if the MySQL is pinging"
      docker-compose exec mysql mysqladmin ping -h localhost -u root -p
    fi
   else
    echo "Container $CONTAINER_NAME is not running."
 fi
done


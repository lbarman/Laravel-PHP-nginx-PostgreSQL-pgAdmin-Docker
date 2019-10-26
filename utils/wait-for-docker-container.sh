#!/bin/bash

CONTAINER="php"

while [ "`(docker inspect -f '{{.State.Running}}' ${CONTAINER} 2>/dev/null)`" != "true" ]; do
    echo "Still waiting on docker container ${CONTAINER}..."
    sleep 1
done

sleep 5
echo "Container ${CONTAINER} is up."

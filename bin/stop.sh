#!/bin/bash

# stop all containers
docker stop $(docker ps -aq)

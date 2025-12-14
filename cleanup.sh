#!/bin/bash

docker image rm -f xavier-flash:20.04
docker image prune -f
docker system prune -af


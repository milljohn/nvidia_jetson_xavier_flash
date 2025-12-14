#!/bin/bash
#
docker run --rm -it \
  --privileged \
  -u $(id -u):$(id -g) \
  -v "$(pwd):/work" \
  -v /dev/bus/usb:/dev/bus/usb \
  xavier-flash:20.04


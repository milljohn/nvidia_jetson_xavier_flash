# Flash NVIDIA Jetson AGX with Connect Tech Rogue AGX101 carrier board

## Summary

Download and flash utility using [JetPack 5.1.5 - L4T r35.6.2](https://connecttech.com/ftp/Drivers/L4T-Release-Notes/Jetson-AGX-Xavier/AGX-35.6.2.pdf).

 - [Rogue Carrier for NVIDIA® Jetson AGX Xavier™](https://connecttech.com/product/rogue-carrier-nvidia-jetson-agx-xavier/)
 - [NVIDIA Jetson Linux 35.6.2](https://developer.nvidia.com/embedded/jetson-linux-r3562)

Documentation states Ubuntu 20.04 is required. Docker allows installation, but the connection seems to reset during flash which seems to reset the resource maping. Running the flash utility under Ubuntu 24.04 works. Some dependancies may need to be installed from the bootstrap script.

## Useage
1. ``./bootstrap.sh``
    - This will run the scripts in order
    - WARNING: This will remove all docker containers and images on the system
2. ``./flash.sh``
    - Runs under Ubuntu 24.04


## Notes
Running `bootstrap.sh` will run all scripts in correct order. You only need to run `flash.sh` for each device.

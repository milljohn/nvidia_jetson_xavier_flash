# Flash NVIDIA Jetson AGX with Connect Tech Rogue AGX101 carrier board

## Summary

Download and flash utility using [JetPack 5.1.5 - L4T r35.6.2](https://connecttech.com/ftp/Drivers/L4T-Release-Notes/Jetson-AGX-Xavier/AGX-35.6.2.pdf).

 - [Rogue Carrier for NVIDIA® Jetson AGX Xavier™](https://connecttech.com/product/rogue-carrier-nvidia-jetson-agx-xavier/)
 - [NVIDIA Jetson Linux 35.6.2](https://developer.nvidia.com/embedded/jetson-linux-r3562)

Documentation states Ubuntu 20.04 is required. Docker allows installation, but the connection seems to reset during flash which seems to reset the resource maping. Running the flash utility under Ubuntu 24.04 works. Some dependancies may need to be installed from the bootstrap script.

## Useage
1. Install [Ubuntu 20.04](https://cdimage.ubuntu.com/releases/20.04/release/)
    - [libvirt](https://github.com/winapps-org/winapps/blob/main/docs/libvirt.md) 
        - fails in the middle of flashing
        - loses usb connection
    - Docker fails part way
        - `build.sh` -- build `Dockerfile`
        - `cleanup.sh` -- remove all docker containers and images
        - `start.sh` -- shell in docker
        - `flash.sh` -- flashes device, hardcoded path ``/work``
    - Probably works on bare metal
2. ``bootstrap_xavier.sh``
    - Installs dependancies
    - Downloads required files
    - Installs SDK
3. ``cd BSP_ROOT/Linux_for_Tegra && sudo ./flash.sh cti/xavier/rogue/base mmcblk0p1``

## Notes

Working on Ubuntu 24.04 host. Used Docker to extract filesystem and SDK.
1. ``sudo ./cleanup.sh``
2. ``sudo ./build.sh``
3. `` sudo ./start.sh``
4. ``./bootstrap_xavier.sh``
    - Flash will probably fail
    - ``exit``
5. ``cd BSP_ROOT/Linux_for_Tegra && sudo ./flash.sh cti/xavier/rogue/base mmcblk0p1``



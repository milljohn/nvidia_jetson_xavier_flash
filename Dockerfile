FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-lc"]

# Core tooling + common Jetson flash deps + usb utils
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    wget \
    sudo \
    git \
    tar \
    bzip2 \
    xz-utils \
    gzip \
    unzip \
    rsync \
    file \
    jq \
    python3 \
    python3-pip \
    usbutils \
    libusb-1.0-0 \
    bc \
    bison \
    flex \
    gawk \
    build-essential \
    libssl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    dosfstools \
    mtools \
    parted \
    kmod \
    udev \
    qemu-user-static \
    libxml2-utils \
    lz4 \
    cpio \
 && rm -rf /var/lib/apt/lists/* \
 && pip install pyyaml

# Convenience: allow sudo without password (script uses sudo a lot)
RUN useradd -m -s /bin/bash builder \
 && echo "builder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/builder \
 && chmod 0440 /etc/sudoers.d/builder

USER builder
WORKDIR /work

# Entry point: expects your script to be mounted at /work/bootstrap_xavier.sh
# (or change the name here to match your script filename)
ENTRYPOINT ["/bin/bash"]


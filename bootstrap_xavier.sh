#!/usr/bin/env bash
set -euo pipefail

#sudo apt update && sudo apt upgrade -y

#sudo apt install qemu-user-static libxml2-utils lz4 -y

echo "Jetson Linux (L4T) + Connect Tech BSP helper"
echo "Jetson Linux page: https://developer.nvidia.com/embedded/jetson-linux-r3562"
echo ""
echo "-------------------------------------------------------------"

DRIVER_URL="https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v6.2/release/jetson_linux_r35.6.2_aarch64.tbz2"
ROOT_FS_URL="https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v6.2/tegra_linux_sample-root-filesystem_r35.6.2_aarch64.tbz2"
BSP_URL="https://connecttech.com/ftp/Drivers/CTI-L4T-AGX-35.6.2-V001.tgz"

# Where to work (keeps things tidy)
WORKDIR="${PWD}/BSP_ROOT"
mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Filenames we expect
DRIVER_TBZ2="jetson_linux_r35.6.2_aarch64.tbz2"
ROOTFS_TBZ2="tegra_linux_sample-root-filesystem_r35.6.2_aarch64.tbz2"
BSP_TGZ="CTI-L4T-AGX-35.6.2-V001.tgz"

download() {
  local url="$1"
  local out="$2"
  if [[ -f "${out}" ]]; then
    echo "[OK] Already downloaded: ${out}"
    return 0
  fi
  echo "[DL] ${out}"
  if command -v curl >/dev/null 2>&1; then
    curl -L --fail --retry 3 --retry-delay 2 -o "${out}" "${url}"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "${out}" "${url}"
  else
    echo "ERROR: Need curl or wget to download files."
    exit 1
  fi
}

# 1) Download everything
download "${DRIVER_URL}" "${DRIVER_TBZ2}"
download "${ROOT_FS_URL}" "${ROOTFS_TBZ2}"
download "${BSP_URL}" "${BSP_TGZ}"

# 2) Extract Jetson Linux driver package (creates Linux_for_Tegra/)
if [[ ! -d "Linux_for_Tegra" ]]; then
  echo "[EXTRACT] ${DRIVER_TBZ2}"
  tar -xjf "${DRIVER_TBZ2}"
else
  echo "[OK] Linux_for_Tegra already exists; skipping driver extract"
fi

# 3) Extract sample root filesystem into Linux_for_Tegra/rootfs
echo "[EXTRACT] ${ROOTFS_TBZ2} -> Linux_for_Tegra/rootfs/"
sudo mkdir -p Linux_for_Tegra/rootfs
sudo tar -C Linux_for_Tegra/rootfs -xjf "${ROOTFS_TBZ2}"

# 4) Extract Connect Tech BSP into Linux_for_Tegra/
echo "[EXTRACT] ${BSP_TGZ} -> Linux_for_Tegra/"
sudo tar -C Linux_for_Tegra -xzf "${BSP_TGZ}"

# 5) Run CTI install script
echo "[RUN] Connect Tech install.sh"
cd Linux_for_Tegra/CTI-L4T
sudo ./install.sh

echo "-------------------------------------------------------------"
echo "Done. Next steps are typically:"
echo "  cd ${WORKDIR}/Linux_for_Tegra"
echo "  (then flash with the correct board config for your CTI carrier)"

cd ${WORKDIR}/Linux_for_Tegra
sudo ./flash.sh cti/xavier/rogue/base mmcblk0p1

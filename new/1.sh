#!/bin/bash
set -e -o pipefail

echo "Checking efi ..."
cat /sys/firmware/efi/fw_platform_size

# If the command returns 64, then system is booted in UEFI mode and has a 64-bit x64 UEFI. If the command returns 32, then system is booted in UEFI mode and has a 32-bit IA32 UEFI; while this is supported, it will limit the boot loader choice to systemd-boot and GRUB. If the file does not exist, the system may be booted in BIOS (or CSM) mode. If the system did not boot in the mode you desired (UEFI vs BIOS), refer to your motherboard's manual. 

echo "Checking internet connection ..."
ping -c3 archlinux.org

timedatectl


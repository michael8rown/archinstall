#!/bin/bash
set -e -o pipefail

#mount $rootdev /mnt
#swapon $swapdev
#mount -o umask=0077 --mkdir $bootdev /mnt/boot

sleep 1

sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sed -i 's/#Color/Color/' /etc/pacman.conf

echo "Installing base system ..."
pacstrap -K /mnt linux-lts linux-lts-headers linux-firmware amd-ucode base base-devel reflector git openssh nano which sudo bash-completion man-db

echo "Generating fstab ..."
genfstab -U /mnt >> /mnt/etc/fstab

echo "Copying install scripts to /mnt ..."
cp -r ../../archinstall /mnt/.

echo "Base installation is complete."
echo "Now entering chroot ..."

arch-chroot /mnt

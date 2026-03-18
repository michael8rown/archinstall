#!/bin/bash
set -e -o pipefail

hwclock --systohc
ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

read -p "What would you like your new hostname to be?  " myhostname

echo "Setting new host name to ${myhostname}"
echo $myhostname >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ${myhostname}" >> /etc/hosts

sleep 1

echo "Updating the mirrorlist ..."

reflector -c US --age 48 --sort rate --latest 20 --protocol https --save /etc/pacman.d/mirrorlist
sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sed -i 's/#Color/Color/' /etc/pacman.conf


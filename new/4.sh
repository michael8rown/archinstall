#!/bin/bash
set -e -o pipefail

echo "Installing the rest of the system ..."

apps=`echo $(cat ./pkgs.log)`

pacman -Syu --noconfirm ${apps}

sleep .5

echo "Enabling system services ..."
#systemctl enable NetworkManager.service
#systemctl enable br0.service
systemctl enable sshd.service
systemctl enable firewalld.service
systemctl enable acpid.service
systemctl enable libvirtd.service
systemctl enable systemd-resolved.service
systemctl set-default multi-user.target

sleep 1

echo "Installing systemd boot ..."
bootctl install

sleep 1

echo "default arch-lts.conf
timeout 5
console-mode keep
editor yes" >> /boot/loader/loader.conf

getroot=`df -h | grep -E '.+/$'`
rootdev=`echo $getroot | sed -E 's/^([^ ]+) .*$/\1/g'`
f=`blkid | grep $rootdev | sed -E 's/^.+ UUID="([^"]+)".+$/\1/g'`

echo "title   Arch Linux LTS
linux   /vmlinuz-linux-lts
initrd  /initramfs-linux-lts.img
options root=UUID=${f} rw" > /boot/loader/entries/arch-lts.conf

sleep .5

echo "Enabling nano syntax highlighting ..."
sed -i 's/^# include \"\/usr\/share\/nano\/\*\.nanorc\"/include "\/usr\/share\/nano\/\*\.nanorc"/' /etc/nanorc

echo
echo "Changing root's password ..."

passwd

echo
echo "Creating a new regular user ..."
read -p "Enter username:  " username

echo
echo "Adding user ${username} ..."

useradd -mG wheel,libvirt $username

echo "Changing ${username}'s password ..."

passwd $username

echo
echo "Adding ${username} to sudoers ..."

echo "%wheel ALL=(ALL:ALL) ALL" | (EDITOR="tee -a" visudo)

echo
echo "Done!"

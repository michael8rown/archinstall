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
#systemctl enable libvirtd.service
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl set-default multi-user.target

sleep 1

echo
echo "Creating scripts for bridged networking ..."

net_dev=$(ip a | grep -E '^[2-9]: e' | sed -E 's/^[2-9]: (e[^:]+):.+/\1/g')
ipaddr=$(ip a show $net_dev | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)
gate=$(ip route | grep default | sed -E 's/default via ([^ ]+) .+/\1/g')

read -p "What is the default gateway (${gate})? " gateway
if [ ! "$gateway" ]; then
  gateway="$gate"
fi

read -p "What is the IP Address (${ipaddr})? " ipv4name
if [ ! "$ipv4name" ]; then
  ipv4name="$ipaddr"
fi

echo "[NetDev]
Name=br0
Kind=bridge" >> /etc/systemd/network/10-br0.netdev

echo "[Match]
Name=br0

[Network]
DHCP=no
Address=$ipv4name/24
Gateway=$gateway
DNS=1.1.1.1
DNS=8.8.8.8" >> /etc/systemd/network/10-br0.network

echo "[Match]
Name=enp1s0

[Network]
Bridge=br0" >> /etc/systemd/network/20-wired.network

sleep .5

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
sed -i -e 's|^# include /usr/share/nano/\*\.nanorc|include /usr/share/nano/*.nanorc|' /etc/nanorc

echo
echo "Changing root's password ..."

passwd

echo
echo "Creating a new regular user ..."
read -p "Enter username:  " username

echo
echo "Adding user ${username} ..."

useradd -mG wheel $username

echo "Changing ${username}'s password ..."

passwd $username

echo
echo "Adding ${username} to sudoers ..."

echo "%wheel ALL=(ALL:ALL) ALL" | (EDITOR="tee -a" visudo)

echo
echo "Done!"

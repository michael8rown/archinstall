#!/bin/bash
set -e -o pipefail

sudo su
pacman-key --init
pacman -Sy git
git clone https://github.com/<username>/archinstall.git
cd archinstall/new
#./1.sh
#./2.sh
#./3.sh
#sudo nano pkgs.log
#sudo nano /etc/fstab
#sudo touch /etc/vconsole.conf # this needs to go just before full package install
#./4.sh
#systemctl enable br0.service (or timer?)
#reboot
#sudo cp etc-ssh-sshd_config /etc/ssh/sshd_config
#sudo cp etc-php-php.ini /etc/php/php.ini
#sudo cp etc-mail.rc /etc/mail.rc
#sudo cp etc-httpd-conf-httpd.conf /etc/httpd/conf/httpd.conf
#sudo cp etc-samba-smb.conf /etc/samba/smb.conf
#sudo cp etc-ssl-certs-ssl-cert-snakeoil.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
#sudo cp etc-ssl-private-ssl-cert-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key
#sudo cp etc-webapps-phpmyadmin-config.inc.php /etc/webapps/phpmyadmin/config.inc.php
#sudo cp usr-local-bin/* /usr/local/bin/.
#sudo cp /home/<username>/Documents/arch_server/transfer/system/*.* /etc/systemd/system/.
#sudo firewall-cmd --permanent --add-port=####/tcp
#sudo firewall-cmd --permanent --add-port=####/udp
#sudo firewall-cmd --permanent --add-port=80/tcp
#sudo firewall-cmd --permanent --add-port=80/udp
#sudo firewall-cmd --permanent --add-port=8080/tcp
#sudo firewall-cmd --permanent --add-port=8080/udp
#sudo firewall-cmd --permanent --add-port=8081/tcp
#sudo firewall-cmd --permanent --add-port=8081/udp
#sudo firewall-cmd --permanent --add-service=http
#sudo firewall-cmd --permanent --add-service=samba
#sudo firewall-cmd --reload
#rm /home/<username>/.ssh/id_*
#ssh-keygen -t rsa
#ssh-keygen -t ed25519
#ssh-copy-id -i ~/.ssh/id_rsa.pub -o Port=#### mmmmmm@dddddd.com
#sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
#sudo systemctl enable --now mariadb.service
#./mytest.sh
#sudo cp /home/<username>/Documents/arch_server/transfer/conf/extra/phpmyadmin.conf /etc/httpd/conf/extra/.
#sudo cp /home/<username>/Documents/arch_server/transfer/conf/extra/httpd-ssl.conf /etc/httpd/conf/extra/.
#sudo systemctl enable --now httpd.service
#sudo pacman -U chromium-144.0.7559.132-1-x86_64.pkg.tar.zst
#sed -i 's/#IgnorePkg   =/IgnorePkg   = chromium/' /etc/pacman.conf
#sudo echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf 
#sudo echo "HandleLidSwitchExternalPower=ignore" >> /etc/systemd/logind.conf 
#sudo echo "HandleLidSwitchDocked=ignore" >> /etc/systemd/logind.conf 
#sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 
#sudo systemctl enable --now smb.service
#sudo smbpasswd -a <username>
#sudo virsh define debian12-20260302.xml
#sudo systemctl enable --now ckJobs.timer lbBkup.timer goToSleep.timer wc.timer hiTemp.timer ckUpd.timer aspenStatus.timer changedFiles.service
#clamav freshclam
#sudo systemctl daemon-reload
#sudo nmcli radio wifi off
#$ sudo nmcli connection add type bridge ifname br0 con-name br0
#$ sudo nmcli connection modify br0 ipv4.addresses 10.0.0.127/24
#$ sudo nmcli connection modify br0 ipv4.gateway 10.0.0.1
#	# maybe skip the next one for now
#	$ sudo nmcli connection modify br0 ipv4.dns "8.8.8.8 8.8.4.4"  # Optional: Set DNS
#$ sudo nmcli connection modify br0 ipv4.method manual
#$ sudo nmcli connection add type bridge-slave ifname enp1s0 con-name bridge-slave-enp1s0 master br0
## Restart NetworkManager and activate the bridge:
#$ sudo systemctl restart NetworkManager.service
#$ sudo nmcli connection up br0
## Verify:
#$ nmcli connection show  # Should list "br0" and "bridge-slave-enp1s0" as active
## ^^^ the above command did not show correct data. had to reboot for changes to take effect
#sudo virsh start debian12
#sudo virsh autostart debian12 
##Domain 'debian12' marked as autostarted
#sudo systemctl enable --now vmCtrl.timer
## to disable it later if needed:
## sudo virsh autostart --disable debian12

#!/bin/bash

if [ ! -f "./smb_config/ubuntu_work.txt" ]; then
    echo "Please run this script in the project root dir."
    exit
fi

echo "[install] bootstrap for new OS [start]"

apt update && apt upgrade -y

echo "[install] vim..."
apt install -y vim 


if [ -x "$(command -v docker)" ]; then
    echo "[installed] docker has been installed"
    # command
else
    echo "[install] docker and docker compose..."
    apt install -y raspberrypi-kernel raspberrypi-kernel-headers 
    curl -sSL https://get.docker.com | sh
    pip3 install docker-compose
fi

echo "[add] the user pi to the group docker, run the following command:"
usermod -aG docker pi

docker version

echo "[increase] the swap size to "
echo "CONF_SWAPSIZE=" >> /etc/dphys-swapfile
echo "CONF_MAXSWAP=10240" >> /etc/dphys-swapfile
echo "CONF_SWAPFACTOR=2" >> /etc/dphys-swapfile

echo "[install] smb..."
chmod -R 777 /home/pi/public
echo "samba-common samba-common/dhcp boolean false" | debconf-set-selections
apt install -y samba samba-common-bin

echo "[update] smb configuration..."
cat smb_config/pi_public.txt >> /etc/samba/smb.conf 


echo "[install] bootstrap for new OS [finished]"

for i in {120..0}
do
    echo "reboot to apply the new configurations in $i seconds \r\n"
    sleep 1
done



reboot -h

exit

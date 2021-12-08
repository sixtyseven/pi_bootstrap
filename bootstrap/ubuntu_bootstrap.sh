#!/bin/bash

if [ ! -f "./smb_config/ubuntu_work.txt" ]; then
    echo "Please run this script in the project root dir."
    exit
fi

# with some limited tests on Ubuntu server 20.04 
echo "[install] bootstrap for new OS [start]"
apt update && apt upgrade -y

# apt install -y openssh-server

# Update the firewall rules to allow ssh traffic
ufw allow ssh

# install docker 
if [ -x "$(command -v docker)" ]; then
    echo "[installed] docker has been installed"
else
    echo "[install] docker..."
    # Add Docker’s official GPG key:
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update && apt upgrade -y
    apt install -y docker-ce docker-ce-cli containerd.io

    echo "[install] docker-compose ..."
    apt install -y python3-pip
    pip3 install docker-compose

    echo "[add] the user pi to the group docker, run the following command:"
    usermod -aG docker ubuntu
fi

# install samba
apt install -y samba

echo "[update] smb configuration..."
mkdir ~/public
cat ./smb_config/ubuntu_public.txt >> /etc/samba/smb.conf 

service smbd restart

ufw allow samba

# create a swap file
# ref: https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
sysctl vm.swappiness=0
echo "sysctl vm.swappiness=0" >> /etc/sysctl.conf
echo "sysctl vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

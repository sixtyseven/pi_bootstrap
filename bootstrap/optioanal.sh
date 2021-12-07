#!/bin/bash

# Constrain ssh from IP addresses
echo "[IP Address Restriction] Constrain remote access from IP addresses"
echo "sshd: ALL" >> /etc/hosts.deny
# allow ips from 192.168.1.0 - 192.168.1.127  
echo "sshd: 192.168.1.0/25" >> /etc/hosts.allow
echo "sshd: localhost" >> /etc/hosts.allow
echo "sshd: 127.0.0.1" >> /etc/hosts.allow

### port 53 is used by systemd-resolved:
### ref https://github.com/pi-hole/docker-pi-hole#tips-and-tricks 
echo "[Pi hole] Disable the stub resolver on Unbuntu"
sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
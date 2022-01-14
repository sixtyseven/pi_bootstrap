#!/bin/bash

# Constrain ssh from IP addresses
echo "[IP Address Restriction] Constrain remote access from IP addresses"
echo "sshd: ALL" >> /etc/hosts.deny
# allow ips from 192.168.1.0 - 192.168.1.127  
echo "sshd: 192.168.1.0/25" >> /etc/hosts.allow
echo "sshd: localhost" >> /etc/hosts.allow
echo "sshd: 127.0.0.1" >> /etc/hosts.allow

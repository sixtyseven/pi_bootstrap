## Linux OS bootstrap for a new raspbian systems (Tested on Ubuntu 20.04)

### Enable ssh

`systemctl enable ssh`
`systemctl start ssh`

### clone repo to local

git clone https://github.com/sixtyseven/pi_bootstrap.git


#### run bootstrap.sh

1. `sudo su` as root user
2. run: `./bootstrap/ubuntu_bootstrap.sh` file
3. [optional] run: `./bootstrap/optional.sh` file
4. reboot


### [Optional] install Argon config if using Argon [others.sh]

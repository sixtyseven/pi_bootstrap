## Firstly, install ubuntu20.04 server on a microSD card (for Pi4)

## Secondly, clone repo to local
`
git clone git@github.com:sixtyseven/pi_work_bootstrap.git
`
## Thirdly, login unbuntu, install softwares

### To ssh your pi remotely
#### Enable ssh

`systemctl enable ssh`
`systemctl start ssh`

#### scp bootstrap.sh
`scp -r ../pi_work_bootstrap user@ip:~/pi_work_bootstrap`

### run bootstrap.sh

1. `sudo su` as root user
2. run: `./bootstrap/ubuntu_bootstrap.sh` file
3. [optional] run: `./bootstrap/optional.sh` file
4. reboot

### [Optional] install Argon config if using Argon [others.sh]

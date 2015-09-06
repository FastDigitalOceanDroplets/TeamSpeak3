#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi
cd
rm -r teamspeak3-server_linux*

# curl -O https://raw.githubusercontent.com/FastDigitalOceanDroplets/TeamSpeak3/master/ts3_setup.sh  && bash ts3_setup.sh
echo
echo
echo "####################################################################"
echo "#      https://github.com/FastDigitalOceanDroplets/TeamSpeak3      #"
echo "#                                                                  #"
echo "# We will go though the proccess of setting up a TeamSpeak3 server #
echo "####################################################################"
echo


echo "Make sure you change your default Droplet password."
passwd

# Creates SWAP on the server
# One of the things that I have lerned is that this kind of servers need swap.
# These fast SSD disks do this even more dicirable to have.
sudo fallocate -l 512M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
sudo sysctl vm.swappiness=10
sudo echo "vm.swappiness=10" >> /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
sudo echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

# Change time zone at your new server
dpkg-reconfigure tzdata

# Set the locale on your computer (is not the smartest way, I accept sugestions to do it interactivily)
export LC_ALL=en_US.UTF-8
export LANG="en_US.UTF-8"
export LANGUAGE=en_US.UTF-8
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment

# Update all your server software
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get autoremove

# Reconfigure locale
apt-get install --reinstall language-pack-en
locale-gen
locale-gen en_US.UTF-8
dpkg-reconfigure locales

apt-get install mc php5-cli


#!/bin/bash

versions=`curl -s http://dl.4players.de/ts/releases/ | \
  grep -Po '(?<=href=")[0-9]+(\.[0-9]+){2,3}(?=/")'`
  
# dirs=`echo $version |awk -F ' ' '{print NF}'`

for dir in versions
do
wget -q --spider http://dl.4players.de/ts/releases/$dir/teamspeak3-server_linux-amd64-$dir.tar.gz
echo $dir $?
done



exit







# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

#curl -O https://raw.githubusercontent.com/FastDigitalOceanDroplets/VestaCP/master/vestacp_post.sh
echo
echo
echo "################################################################"
echo "#     https://github.com/FastDigitalOceanDroplets/VestaCP      #"
echo "#                                                              #"
echo "# We will go though the proccess of setting up a full web      #"
echo "# server. It will have web, php, email, ftp, dns, mysql all in #"
echo "# a fantastic easy and smart to use control panel called Vesta.#"
echo "#                                                              #"
echo "# Vesta is free, but you can get paid help at their site.      #"
echo "#                    https://vestacp.com                       #"
echo "################################################################"
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

# install vesta with admin's email
wget http://dl.4players.de/ts/releases/$version/TeamSpeak3-Client-linux_amd64-$version.run
sudo adduser --disabled-login teamspeak
tar xzf teamspeak3-server_linux-amd64-3.0.11.4.tar.gz
sudo mv teamspeak3-server_linux-amd64 /usr/local/teamspeak
sudo chown -R teamspeak:teamspeak /usr/local/teamspeak
sudo ln -s /usr/local/teamspeak/ts3server_startscript.sh /etc/init.d/teamspeak
sudo update-rc.d teamspeak defaults
sudo service teamspeak start
w3m -dump -o display_charset=UTF-8 http://dl.4players.de/ts/releases/  > output.txt

versions=`curl -s http://dl.4players.de/ts/releases/ | \
  grep -Po '(?<=href=")[0-9]+(\.[0-9]+){2,3}(?=/")' | \
  sort -Vr | head -1`
  
dirs=`echo $version |awk -F ' ' '{print NF}'`

for dir in versions
do
wget -q --spider http://dl.4players.de/ts/releases/$dir/teamspeak3-server_linux-amd64-$dir.tar.gz
echo $dir $?
done

#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

cd /usr/local/teamspeak/files/virtualserver_1/channel_1
echo

for bkp in `find -name "ts3_bkp_*" -type f`
do
    echo $bkp
done


read -p "Type the file to restore: " opt
    mkdir /root/tmp_ts/
    cp /usr/local/teamspeak/files/virtualserver_1/channel_1/$opt /root/tmp_ts/
    cd /root/tmp_ts/
    service teamspeak stop
    rm -R /usr/local/teamspeak/files/
    rm /usr/local/teamspeak/ts3server.sqlitedb
    tar -xzf $opt

    chown -R teamspeak:teamspeak ./

    rm $opt
    cd /root
    mv /root/tmp_ts/ts3server.sqlitedb /usr/local/teamspeak/ts3server.sqlitedb
    mv /root/tmp_ts/files  /usr/local/teamspeak/
    rm -R /root/tmp_ts
    service teamspeak start
    exit
    

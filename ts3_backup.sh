#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

if [ $# -ne 0 ]; then
    echo "No arguments neeaded. Ignoring arguments."
fi
filename="ts3_bkp_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz"
cd /usr/local/teamspeak/files/
tar -czvf $filename ts3server.sqlitedb files/

echo "File $filename is ready to download from teamspeak client default folder."
echo "Come back here and type 'ok' when you are done"
input=""
while [ $input -ne "ok" ];do
    read $input
done
rm $filename
exit


if [ ! -f /usr/local/teamspeak/files/virtualserver_1/channel_1/$1 ]; then
    echo "File not found!"
    echo "Upload file thoug TS3 to the default channel first"
    exit 1
else
    echo "Aca esta!"
    # hacer algo
    

    
    
    rm /usr/local/teamspeak/files/virtualserver_1/channel_1/$1
    exit
fi


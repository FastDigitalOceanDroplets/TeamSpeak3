#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

if [ $# -ne 0 ]; then
    echo "No arguments neeaded. Ignoring arguments."
fi

rm -R /usr/local/teamspeak/files/virtualserver_1/channel_1/ts3_bkp_* 2> /dev/null

filename="ts3_bkp_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz"
cd /usr/local/teamspeak/
tar -qczvf /root/$filename ts3server.sqlitedb files/
mv /root/$filename /usr/local/teamspeak/files/virtualserver_1/channel_1/
chown teamspeak:teamspeak /usr/local/teamspeak/files/virtualserver_1/channel_1/$filename

echo "File $filename is ready to download from"
echo "teamspeak client default folder."
echo "Come back here and type 'ok' when you are done"
input=""
while [[ "$input" != "ok" ]]; do
    read input
done

rm /usr/local/teamspeak/files/virtualserver_1/channel_1/$filename
exit

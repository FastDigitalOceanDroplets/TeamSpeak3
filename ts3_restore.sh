#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

if [ $# -eq 0 ]
  then
    echo "No filename provided."
    exit 1
fi


if [ ! -f /usr/local/teamspeak/files/virtualserver_1/channel_1/$1 ]; then
    echo "File not found!"
    echo "Upload file thoug TS3 to the default channel first"
    exit 1
else
    echo "Aca esta!"
    # hacer algo
    ls | grep "^ts3_bkp_" 
    
    
    
    #rm /usr/local/teamspeak/files/virtualserver_1/channel_1/$1
    exit
fi


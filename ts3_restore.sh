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
    exit 1
else
    echo "Aca esta!"
    # hacer algo
    rm /usr/local/teamspeak/files/virtualserver_1/channel_1/$1
    exit
fi


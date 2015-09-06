#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

    cd /usr/local/teamspeak/files/virtualserver_1/channel_1
    
    prompt="Please select a file:"
    options=( $(find -maxdepth 1 -print0 | xargs -0 | sed -r 's/^.{2}//') )
    PS3="$prompt "
    select opt in "${options[@]}" "Quit" ; do 
        if (( REPLY == 1 + ${#options[@]} )) ; then
            exit
    
        elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
            #echo  "You picked $opt which is file $REPLY"
            break

        else
            echo "Invalid option. Try another one."
        fi
    done

    service teamspeak stop
    rm -R /usr/local/teamspeak/files/
    rm /usr/local/teamspeak/ts3server.sqlitedb
    tar -xzf /usr/local/teamspeak/files/virtualserver_1/channel_1/$opt
    mv /usr/local/teamspeak/files/virtualserver_1/channel_1/ts3server.sqlitedb /usr/local/teamspeak/ts3server.sqlitedb
    mv /usr/local/teamspeak/files/virtualserver_1/channel_1/files  /usr/local/teamspeak/
    service teamspeak start
    # rm /usr/local/teamspeak/files/virtualserver_1/channel_1/$opt
    exit
#fi


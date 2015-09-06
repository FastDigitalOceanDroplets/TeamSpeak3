#!/bin/bash

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

#if [ $# -eq 0 ]
#  then
#    echo "No filename provided."
#    exit 1
#fi


#if [ ! -f /usr/local/teamspeak/files/virtualserver_1/channel_1/$1 ]; then
#    echo "File not found!"
#    echo "Upload file thoug TS3 to the default channel first"
#    exit 1
#else
    cd /usr/local/teamspeak/files/virtualserver_1/channel_1
    echo "Aca esta!"
    # hacer algo
    
prompt="Please select a file:"
options=( $(find -maxdepth 1 -print0 | xargs -0) )
echo options
exit
PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done    

ls -ld $opt
    
    
    for lines in `ls | grep  ^ts3_bkp_.*\.tar.gz$`
    do
        echo $lines
    done
    
    
    #rm /usr/local/teamspeak/files/virtualserver_1/channel_1/$1
    exit
#fi


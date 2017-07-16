#!/bin/bash
clear

#tmux new-session -s Menu 

# Declare Variables
HOSTNAME=$(hostname)
ID=$(id -u)
IPADDRESS=$(hostname -I | awk '{print $1}')

[ "$ID" -ne 0 ] && echo "This should be run as root." && sleep 2 && exit

# check if in tmux menu
if [ ! "$TMUX" ]; then
    if [ "$1" == '--jon' ]; then
	[ ! "$TMUX" ] && tmux a -t "JonThan:menu" 2>/dev/null || tmux new-session -s "JonThan" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
    else
        [ ! "$TMUX" ] && tmux a -t "Main:menu" || tmux new-session -s  "Main" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
    fi
fi



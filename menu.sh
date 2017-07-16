#!/bin/bash
clear

#tmux new-session -s Menu 

# Declare Variables
HOSTNAME=$(hostname)
ID=$(id -u)
IPADDRESS=$(hostname -I | awk '{print $1}')
jonSTATUS=$(tmux ls | grep "JonThan" | grep -i "attached" >/dev/null; echo $?)
mainSTATUS=$(tmux ls | grep "Main" | grep -i "attached" >/dev/null; echo $?)




# check if sudo. I left this here so that you can soure the script variables and stop the script here.;

[ "$ID" -ne 0 ] && echo "This should be run as root." && sleep 2 && exit

# test if IP address is zero value.
[ -z "${IPADDRESS}" ] && echo "IP address is a zero value, make sure you're on network and have a valid IP." && sleep 2 && exit

# See if any tmux sessions already running, if so, attach to it instead of starting new session.
[ "$mainSTATUS" = 0 ] && tmux a -t "Main:menu" || tmux new-session -s "Main" $0 \; rename window "menu" \; set mouse on $
[ "$jonSTATUS" = 0 ] && tmux a -t "JonThan:menu" || tmux new-session -s "JonThan" $0 \; rename window "menu" \; set mouse on $

# check if in tmux menu
#if [ ! "$TMUX" ]; then
#    if [ "$1" == '--jon' ]; then
#	[ ! "$TMUX" ] && tmux a -t "JonThan:menu" 2>/dev/null || tmux new-session -s "JonThan" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
#    else
#        [ ! "$TMUX" ] && tmux a -t "Main:menu" || tmux new-session -s  "Main" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
#    fi
#fi



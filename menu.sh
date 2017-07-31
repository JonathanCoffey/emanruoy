#!/bin/bash
clear


# Declare Variables
echo "Declaring variables..."
HOSTNAME=$(hostname)
ID=$(id -u)
IPADDRESS=$(hostname -I | awk '{print $1}')
jonSTATUS=$(tmux ls 2>/dev/null | grep "JonThan" | grep -i "attached" >/dev/null; echo $?)
mainSTATUS=$(tmux ls 2>/dev/null | grep "Main" >/dev/null; echo $?) # tmux Main session already running? true or false.
mainATTACHED=$(tmux ls 2>/dev/null | grep "Main" | grep -i "attached" >/dev/null; echo $?)



# check if sudo. I left this here so that you can soure the script variables and stop the script here.
echo "Checking for sudo..."
[ "$ID" -ne 0 ] && echo "This should be run as root." && sleep 2 && exit


# see if already in a tmux session
echo "Checking if  already in a tmux session..."
if [ ! "${TMUX}" ]; then
	echo "Not currently in a tmux session..."
else
	echo "Already in a tmux session..."
	sleep 2 && exit
fi
sleep 3

# test if IP address is zero value.
echo "Ckecking if IP address is zero..."
[ -z "${IPADDRESS}" ] && echo "IP address is a zero value, make sure you're on network and have a valid IP." && sleep 2 && exit

# See if any tmux sessions already running, if so, attach to it instead of starting new session.
echo "Checking if tmux already running..."
[ "$mainSTATUS" = 0 ] && tmux a -t "Main:menu" || tmux new-session -s "Main"  \; rename-window "menu" \; set mouse on \;
#[ "$jonSTATUS" = 0 ] && tmux a -t "JonThan:menu" || tmux new-session -s "JonThan" $0 \; rename-window "menu" \; set mouse on $

#tmux new-session -s Menu

# check if in tmux menu
#if [ ! "$TMUX" ]; then
#    if [ "$1" == '--jon' ]; then
#	[ ! "$TMUX" ] && tmux a -t "JonThan:menu" 2>/dev/null || tmux new-session -s "JonThan" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
#    else
#        [ ! "$TMUX" ] && tmux a -t "Main:menu" || tmux new-session -s  "Main" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
#    fi
#fi


echo "END OF FILE."
exit

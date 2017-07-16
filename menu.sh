#!/bin/bash
clear

#tmux new-session -s Menu 

# Declare Variables
HOSTNAME=$(hostname)
ID=$(id -u)
IPADDRESS=$(hostname -I | awk '{print $1}')
jonSTATUS=$(tmux ls | grep "JonThan" | grep -i "attached" >/dev/null; echo $?)
mainSTATUS=$(tmux ls | grep "Main" | grep -i "attached" >/dev/null; echo $?)
tmuxCHECK=$(apt-cache policy tmux | grep "Installed:" | grep '(none)' >/dev/null; echo $?) # 0 value if tmux not installed. 



# check if sudo. I left this here so that you can soure the script variables and stop the script here.;
[ "$ID" -ne 0 ] && echo "This should be run as root." && sleep 2 && exit

# test if IP address is zero value.
[ -z "${IPADDRESS}" ] && echo "IP address is a zero value, make sure you're on network and have a valid IP." && sleep 2 && exit


echo "Running as root. Your IPV4 is: ${IPADDRESS}"
sleep 2

# check if tmux installed.
[ "${tmuxCHECK}" = 0 ] && echo "Installing tmux..." && apt install tmux -y >/dev/null || echo "Tmux is already installed."
sleep 3


# See if any tmux sessions already running, if so, attach to it instead of starting new session.
#[ "$mainSTATUS" = 0 ] && tmux a -t "Main:menu" || tmux new-session -s "Main" $0 \; rename window "menu" \; set mouse on $
#[ "$jonSTATUS" = 0 ] && tmux a -t "JonThan:menu" || tmux new-session -s "JonThan" $0 \; rename window "menu" \; set mouse on $

# check if in tmux menu
#if [ ! "$TMUX" ]; then
#    if [ "$1" == '--jon' ]; then
#	[ ! "$TMUX" ] && tmux a -t "JonThan:menu" 2>/dev/null || tmux new-session -s "JonThan" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
#    else
#        [ ! "$TMUX" ] && tmux a -t "Main:menu" || tmux new-session -s  "Main" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
#    fi
#fi


# Structure

# Is tmux installed? If not, install it. 

# Is "Main" already an existing tmux session?
# # Does the user want to attach or end the already running one? 
  #

# Create new tmux session named "Main".

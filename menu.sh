#!/bin/bash

# A fresh start.
clear

# list already running tmux sessions
echo "CURRENTLY RUNNING SESSIONS"
echo '-------------------------------'
tmux ls
echo '-------------------------------'

# Declare Variables
read -p 'Type a running session name to attach, or type a unique name to create a new session: ' sessionName # Asks user to name a tmux session, stores it in sessionName.
status=$(tmux ls 2>/dev/null | grep "${sessionName}" >/dev/null; echo $?) # checks if sessionName already running. 0 if yes, 1 if not.
#mainSTATUS=$(tmux ls 2>/dev/null | grep ""${sessionName}"" >/dev/null; echo $?) # tmux "${sessionName}" session already running? true or false. 
# disabled for now, not forcing "Main" as name.
#mainATTACHED=$(tmux ls 2>/dev/null | grep ""${sessionName}"" | grep -i "attached" >/dev/null; echo $?)


# check if sudo. I left this here so that you can soure the script variables and stop the script here.
#[ "$ID" -ne 0 ] && echo "This should be run as root." && sleep 2 && exit
# I disabled the sudo check, as you may want to run as any user without forcing you to run as root. 
# For the sake of automation, run as root. For security, run normally and use password when prompted for tools that # require root privs. 


if [ ! "${TMUX}" ]; then # TMUX variable only exists in tmux. The test is saying: if not true, then... but if it is true, then this is false and goes to ELSE. 
  if [ "${status}" = 0 ]; then # if 0, then the chosen tmux session is already up.
    echo "TMUX SERVER: "${sessionName}": UP."
    sleep 1
    clear
    if [ "${status}" = 0 ]; then
      echo "TMUX SERVER: "${sessionName}": DETACHING CLIENTS."
      sleep 1
      tmux detach -s "${sessionName}"
      tmux a -t "${sessionName}"
      clear
    else
      echo "TMUX SERVER: "${sessionName}": ATTACHING TO SERVER."
      sleep 1
      tmux a -t "${sessionName}"
      clear
      exit
    fi
  else
    echo "TMUX SERVER: "${sessionName}": STARTING."
    sleep 1
    tmux new-session -s "${sessionName}"
    clear
    exit
  fi
else
  read -p 'You are already attached to tmux. Do you wish to detach? Y/n ' input1
  if [ "${input1}" = "y" ]; then
    clear
    echo "detaching from tmux in: 3"
    sleep 1
    clear
    echo "detaching from tmux in: 2"
    sleep 1
    clear
    echo "detaching from tmux in: 1"
    sleep 1
    clear
    tmux new-session -d -s "${sessionName}" && tmux switch-client -t "${sessionName}" || tmux switch-client -t "${sessionName}"
  elif [ "${input1}" = "n" ]; then
    clear
    echo "Okay, you can stay here."
    sleep 2
    clear
    exit 
  elif [ "${input1}" = "" ]; then
    clear
    echo "Please enter y or n"
    echo "Re-run script again."
    sleep 2
    clear
  else
    clear
    echo "Invalid option, please enter 'y' or 'n'"
    sleep 2
    clear
  fi
fi

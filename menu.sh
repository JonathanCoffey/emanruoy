#!/bin/bash
clear

# check if tmux installed
y=$(type tmux 2>/dev/null)
[ ! "$y" ] && echo "Installing tmux with apt..." && sudo apt install -yqq tmux >/dev/null 2>/dev/null
clear

# list already running tmux sessions
echo "CURRENTLY RUNNING SESSIONS"
echo '-------------------------------'
tmux ls
echo '-------------------------------'

# Declare Variables
read -p 'Enter a session name: ' sessionName # Asks user to name a tmux session, stores it in sessionName.
status=$(tmux ls 2>/dev/null | grep "${sessionName}" >/dev/null; echo $?) # checks if sessionName already running. 0 if yes, 1 if not.


if [ ! "${TMUX}" ]; then # TMUX variable only exists in tmux. The test is saying: if not true, then... but if it is true, then this is false and goes to ELSE. 
  if [ "${status}" = 0 ]; then # if 0, then the chosen tmux session is already up.
    clear
    if [ "${status}" = 0 ]; then
      tmux detach -s "${sessionName}"
      tmux a -t "${sessionName}"
      clear
    else
      tmux a -t "${sessionName}"
      clear
      exit
    fi
  else
    tmux new-session -s "${sessionName}" \; set mouse on 2>/dev/null \;
    clear
    exit
  fi
else
  read -p 'Switch sessions? Y/n ' input1
  if [ "${input1}" = "y" ]; then
    clear
    tmux new-session -d -s "${sessionName}" \; set mouse on 2>/dev/null \; && tmux switch-client -t "${sessionName}" || tmux switch-client -t "${sessionName}"
  elif [ "${input1}" = "n" ]; then
    clear
    exit 
  elif [ "${input1}" = "" ]; then
    clear
    echo "Please enter y or n"
    echo "Re-run script again."
    sleep 1
    clear
  else
    clear
    echo "Invalid option, please enter 'y' or 'n'"
    sleep 1
    clear
  fi
fi

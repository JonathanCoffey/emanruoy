#!/bin/bash
clear

# check if tmux installed
y=$(type tmux 2>/dev/null)
[ ! "$y" ] && echo "Installing tmux with apt..." && sudo apt install -yqq tmux >/dev/null 2>/dev/null
clear

p1() {
# list already running tmux sessions
echo "CURRENTLY RUNNING SESSIONS"
echo '-------------------------------'
tmux ls
echo '-------------------------------'
}

q1() {
# Declare Variables
read -p 'Enter a session name: ' sessionName # Asks user to name a tmux session, stores it in sessionName.
status=$(tmux ls 2>/dev/null | grep "${sessionName}" >/dev/null; echo $?) # checks if sessionName already running. 0 if yes, 1 if not.
}

soloMode() {
p1
q1
if [ ! "${TMUX}" ]; then # TMUX variable only exists in tmux. The test is saying: if not true, then... but if it is true, then this is false and goes to ELSE. 
  if [ "${status}" = 0 ]; then # if 0, then the chosen tmux session is already up.
    tmux detach -s "${sessionName}"
    tmux a -t "${sessionName}"
    clear
  else
    tmux new-session -s "${sessionName}" \; set mouse on 2>/dev/null \;
    tmux a -t "${sessionName}"
  fi
else
  read -p 'Switch sessions? Y/n ' input1
  if [ "${input1}" = "y" ]; then
    clear
    tmux detach -s "${sessionName}" 2>/dev/null
    tmux new-session -d -s "${sessionName}" \; set mouse on 2>/dev/null \; && tmux switch-client -t "${sessionName}" || tmux switch-client -t "${sessionName}" \; set mouse on 2>/dev/null
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
}

normalMode() {
p1
q1
if [ ! "${TMUX}" ]; then
  if [ "${status}" = 0 ]; then
    tmux a -t "${sessionName}"
    clear
  else
    tmux new-session -s "${sessionName}" \; set mouse on 2>/dev/null \;
    tmux a -t "${sessionName}"
  fi
else
  read -p 'Switch sessions? Y/n ' input1
  if [ "${input1}" = "y" ]; then
    if [ "${status}" = 0 ]; then
      clear
      tmux switch-client -t "${sessionName}" \; set mouse on \;
    else
      clear
      tmux new-session -d -s "${sessionName}" \; set mouse on \;
      tmux switch-client -t "${sessionName}"
    fi
  elif [ "${input1}" = "n" ]; then
    clear
    exit
  elif [ "${input1}" = "" ]; then
    clear
    echo "Invalid option, please enter 'y' or 'n'"
    sleep 1
    clear
  fi
fi  
}



###################################### START OF SCRIPT ######################################


case $1 in 
  -d) # start by detaching users and running as a single user.
    soloMode
    exit
    ;;
  "") # start normally if no args are passed.
    normalMode
    exit
    ;;
  *) # all other args
    clear
    echo "Correct switches for $0 are"':' '-d'
    echo "Switches are not required though, this script can be run with no args."
    sleep 1
    exit
esac



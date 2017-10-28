#!/bin/bash
#####################################################################
####
#### Beginning new script code here
####
#####################################################################
usage_msg() {
clear
echo "
Program: menu.sh

The menu.sh script is designed to manage and control muliple tmux
sessions at a time. You can easily change contextually through 
different menus or layouts.

Usage: ${1##*/} [-?vV] [-m message]

 Where:
    -m = message - change the message to display
    -v = Verbose mode - displays displayms function info
    -V = Very Verbose Mode - debug output displayed
    -? = Help - display this message

Author: Jonathan Coffey (JonathanCoffey1087@gmail.com)

\"AutoContent\" enabled
\"Multi-Shell\" enabled
"
}
#####################################################################
####
#### Description:
####
#### Place fell text description of shell function here.
####
#### Assumptions:
####
#### Provide list of assumptions your shell function makes,
#### with a description of each assumption.
####
#### Dependencies:
####
#### tmux , acpi , UPower , htop , openssh-server , ssh
#### stress, memtester, openglmark2 , xawtv , motion
#### cvlc , vlc , xplayer , smartmontools
####
#### Products: 
#### 
#### outputs machine information commonly needed for computer diagnosis
#### and repair. Some outputs produced by this script are S.M.A.R.T
#### data, temperature and sensor information, webcam and camera tools
#### vlc for playback of test audio files, hardware testing sofwtware
#### will be used for burn-in and testing. 
####
#### Configured Usage:
####
#### Describe how your shell function should be used.
####
#### Details:
####
#### Place nothing here, the details are your shell function.
####
#####################################################################
configure_displayms()
{
####
#### Notice this function is a POSIX function so that it can see local
#### and global variables from calling functions and scripts.
####
#### Configuration parameters can be stored in a file and
#### this script can be dynamically reconfigured by sending
#### the running script a HUP signal using the kill command.
#### ex.) kill -1 <pid>
####
#### Configuration variables can be defined in the configuration file using
#### the same syntax as defining a shell variable, e.g.: VARIABLE="value"

  CFILE=~/.displayms.conf

  (( VERBOSE == TRUE )) && echo "# Configuration File: ${CFILE}"

  if [[ -f ${CFILE} ]]; then
    (( VERBOSE == TRUE )) && cat ${CFILE}
    . ${CFILE}
  fi

  return 0
}

#####################################################################
####
#### End of new script code here
####
#####################################################################
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

scr1() {
case $1 in 
  -d) # start by detaching users and running as a single user.
    soloMode
    exit
    ;;
  -sys) # start system menu template
    ./files/templates/system.sh
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
} 

scr1 $1

# Fix issue. When passing -d switch and giving the name of the session you're attached to should
# prompt user that perhaps they gave the wrong session name. There is no reason to detach
# intentionally this way, there are already commands for that. 

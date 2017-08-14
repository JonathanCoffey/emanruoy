#!/bin/bash

# A fresh start.
clear

# Declare Variables
ID=$(id -u)
mainSTATUS=$(tmux ls 2>/dev/null | grep "Main" >/dev/null; echo $?) # tmux Main session already running? true or false.
mainATTACHED=$(tmux ls 2>/dev/null | grep "Main" | grep -i "attached" >/dev/null; echo $?)

# check if sudo. I left this here so that you can soure the script variables and stop the script here.
#[ "$ID" -ne 0 ] && echo "This should be run as root." && sleep 2 && exit


if [ ! "${TMUX}" ]; then
  if [ "${mainSTATUS}" = 0 ]; then
    echo "TMUX SERVER: Main: UP."
    sleep 1
    clear
    if [ "${mainATTACHED}" = 0 ]; then
      echo "TMUX SERVER: Main: DETACHING CLIENTS."
      sleep 1
      tmux detach -s Main
      tmux a -t Main
      clear
    else
      echo "TMUX SERVER: Main: ATTACHING TO SERVER."
      sleep 1
      tmux a -t Main
      clear
      exit
    fi
  else
    echo "TMUX SERVER: Main: STARTING."
    sleep 1
    tmux new-session -s Main
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
    tmux detach
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

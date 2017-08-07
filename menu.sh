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
fi

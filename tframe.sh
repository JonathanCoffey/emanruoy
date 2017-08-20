#!/bin/bash

# start tmux main framework
clear
read -p 'Please enter a session name: ' SESSION

# Configuring 'Menu' window with cmatrix borders.
echo "Starting session '${SESSION}'."
tmux -2 new-session -d -s "${SESSION}"
  tmux split-window -h

  # PANE 0
  tmux select-pane -t 0
  #tmux send-keys "tail -f /var/log/syslog" C-m
  # watch lsblk
  tmux send-keys "watch -td lsblk" C-m

  # PANE 1
  tmux select-pane -t 1
  # open htop
  tmux send-keys "htop" C-m
  # resize pain 1 and expand it left 40 units
  for i in {1..40}; do
    tmux resize-pane -L
  done

  tmux split-window
  tmux select-pane -t 2
  tmux send-keys "./files/bl.sh" C-m

  sleep 0.5
  tmux rename-window -t 1 "Menu"

# Attach to created session.
tmux a -t "${SESSION}"


#!/bin/bash

# Start making useful menus! You've landed here and found this menu useful thus far. 
# Simple "ask user" style minimalistic lazy ssh connect. Will build default "live img" options as well. ex)mint@$host_variable .


# asking for hostname
echo "target hostname: "
read in_var01


# Asking for pw
echo "password: "
read in_var02
# echo "You entered: $in_var02"

# asking target host ip to attempt connection to. 
echo "ssh target IP: "
read in_var03
# echo "You entered: $in_var03"

# starting the ssh connection.
sshpass -p "$in_var02" ssh "$in_var01"@"$in_var03"
clear

#!/bin/bash
# check for elevated priv's
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

# set hostname variable
hname=$(hostname -I)

# install openssh-server
echo 'Installing openssh-server, please wait...'
sudo apt install -qqy openssh-server > /dev/null 2>/dev/null 

echo 'setting default password to 'asdf1234''
echo "mint:asdf1234" | sudo chpasswd


# get host
echo 'Get host'
clear
echo "********************"
echo "$hname" | awk {'print $1'}
echo "********************"
echo "$hname" | awk {'print $2'}
echo "********************"
echo
echo "End of autoSSH script"
sleep 2

# NOTES #
# Mount SMB share locally with blank user and pass. 
# sudo mount -t cifs -ouser="",password="",ro //10.1.10.10.12/smb tk/

# SCRIPT GOALS #
# 1. Check if openssh-server installed, if not, install. 
# 2. If installed, change to default password "asdf1234".
# 3. Append hostname to a log file that server tails for most recent hosts. 
#  example) hostname -I >> ~/tk/sshlog.txt 
# 4. Start a tmux session on mint client machine with three (3) panes. (maybe separate script, different function). 




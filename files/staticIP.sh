#!/bin/bash
# script break line to seperate from menu text.
echo "*****************************"
echo "*****************************"

# Script to find and set static IP address on ethernet adapter.


# this will simplify the ethernet adapter name. 
# variable = result of (ifconfig , grab lines matching -i "ethernet", awk grabs Number Row 1 and prints first column value. 
# grep -i "wl" excludes any wireless lan adapters that are detected when grepping for "ethernet".
# Since this is for server setup and not run on clients, ethernet should be reported first.
eth0=$(ifconfig | grep -i "ethernet" | grep -iv "wl" | awk 'NR==1{print $1}')
echo "Detected Ethernet adapter: $eth0"

# show hostname -I prior to running static script.
curipv4=$(hostname -I | awk '{print $1}')
echo "Your current ipv4 is: $curipv4"
echo "*****************************"
echo "*****************************"

# adding ethernet connection profile with manual IP configuration. nmcli
nmcli con add con-name 10Twelve ifname $eth0 type ethernet autoconnect no
nmcli con mod 10Twelve ipv4.addresses 10.1.10.12/24
nmcli con mod 10Twelve ipv4.gateway 10.1.10.1
nmcli con mod 10Twelve ipv4.dns "8.8.8.8 8.8.4.4"
nmcli con mod 10Twelve +ipv4.dns 10.1.10.1
nmcli con up 10Twelve
echo "*****************************"
echo "*****************************"

# show hostname -I after running static script.
newipv4=$(hostname -I | awk '{print $1}')
echo "Your new ipv4 is: $newipv4"
echo "*****************************"
echo "*****************************"

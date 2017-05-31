#!/bin/bash

# Script to find and set static IP address on ethernet adapter.
# learn nmcli (network manager command line interface) tool in order to establish connection profile and static IP on LServer


# this will simplify the ethernet adapter name. 
# variable = result of (ifconfig , grab lines matching -i "ethernet", awk grabs Number Row 1 and prints first column value. 
# Could see bug if wifi is only reported as it also contains string "Ethernet", need a way to exclude it.
# Since this is for server setup and not run on clinents, ethernet should be reported first.
eth0=$(ifconfig | grep -i "ethernet" | awk 'NR==1{print $1}')
echo "Detected Ethernet adapter: $eth0"

# Network manager does nor nmcli uses this config. Network manager would need to be removed for this to work.
# Keeping for later reference or in case we need to find another way. 

 #echo "iface $eth0 inet static" >> /etc/network/interfaces
 #echo "address 10.1.10.12" >> /etc/network/interfaces
 #echo "netmask 255.255.255.0" >> /etc/network/interfaces
 #echo "gateway 10.1.10.1" >> /etc/network/interfaces
 #echo "dns-nameservers 10.1.10.1" >> /etc/network/interfaces

# adding ethernet connection profile with manual IP configuration. nmcli
nmcli con add con-name 10Twelve ifname $eth0 type ethernet autoconnect no
nmcli con mod 10Twelve ipv4.addresses 10.1.10.12/24
nmcli con mod 10Twelve ipv4.gateway 10.1.10.1
nmcli con mod 10Twelve ipv4.dns "8.8.8.8 8.8.4.4"
nmcli con mod 10Twelve +ipv4.dns 10.1.10.1
 #nmcli con mod 10Twelve ipv6.dns ""
nmcli con show 10Twelve | less

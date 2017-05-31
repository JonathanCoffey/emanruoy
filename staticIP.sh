# file to set static IP address on ethernet adapter.


#!/bin/bash

# this will simplify the ethernet adapter name.
eth0=$(ifconfig | grep -i "ethernet" | awk '{print $1}')

# output the new value of variable $eth0
echo $eth0

echo "iface $eth0 inet static" >> /etc/network/interfaces
echo "address 10.1.10.12" >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "gateway 10.1.10.1" >> /etc/network/interfaces
echo "dns-nameservers 10.1.10.1" >> /etc/network/interfaces

echo "Completed network static settings for 10.1.10.12"

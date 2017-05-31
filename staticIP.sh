# file to set static IP address on ethernet adapter.


#!/bin/bash

# this will simplify the ethernet adapter name.
eth0=$(ifconfig | grep -i "enp" | awk '{print $1}')

echo $eth0



#!/bin/bash
# comment

bat0=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | cut -d ':' -f 2)
bat1=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "percentage:" | cut -d ':' -f 2)




echo "Starting battery loop"
while (sleep 5); do
  clear
  echo "B1:""${bat0}"
  echo "B2:""${bat1}"
done


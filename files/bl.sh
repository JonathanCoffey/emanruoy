#!/bin/bash
# Simple battery loop to grab percentage of charge remaining1


echo "Starting battery loop"
while (sleep 5); do
  bat0=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | cut -d ':' -f 2)
  bat1=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "percentage:" | cut -d ':' -f 2)
  clear
  echo "B1:""${bat0}"
  echo "B2:""${bat1}"
  acpi -t
  acpi -a
  acpi -b
done

#########################################################################
# additional energy info, will be separated later into individual scripts
# Thermal info
acpi -t
# Adapter or AC info
acpi -a
# battery info to be cross-referenced with upower later
acpi -b


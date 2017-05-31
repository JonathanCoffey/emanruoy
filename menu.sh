#!/bin/bash
# Bash Menu Script Example
clear
PS3='Please select an option: '
echo
echo "Main Menu"
echo
echo
options=("static IP" "software Update" "autoSSH/SMB" "Quit")
select opt in "${options[@]}"
do 
   case $opt in
        "static IP")
            ./files/staticIP.sh
            ;;
        "software Update")
            echo "in dev"
	    ;;
        "autoSSH/SMB")
            ./autoSSH.sh
	    ./autoSMB.sh
            ;;
	"TBD")
	    echo "To Be Determined"
	    ;;
        "TBD")
            echo "To Be Determined"
	    ;;
   	"TBD")
            echo "To Be Determined"
	    ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
    # echo "breakout CASE"
done
echo "breakout SELECT"

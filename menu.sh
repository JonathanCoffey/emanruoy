#!/bin/bash
# Bash Menu Script Example
clear
PS3='Please select an option: '
echo
echo "Main Menu"
echo
echo
options=("init LServer" "autoSMB" "autoSSH/SMB" "Quit")
select opt in "${options[@]}"
do 
   case $opt in
        "init LServer")
            echo "echo in dev"
            ;;
        "autoSMB")
            ./autoSMB.sh
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

#!/bin/bash
# Bash Menu Script Example
clear
PS3='Please select an option: '
echo
echo "GLaDOS - I'm bringing the cake..."
echo
echo
options=("autoSSH" "autoSMB" "autoSSH/SMB" "Quit")
select opt in "${options[@]}"
do 
   case $opt in
        "autoSSH")
            ./autoSSH.sh
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

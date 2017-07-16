#!/bin/bash
clear



#tmux new-session -s Menu 

# Declare Variables
HOSTNAME=$(hostname)
ID=$(id -u)
IPADDRESS=$(hostname -I | awk '{print $1}')

[ "$ID" -eq 0 ] && echo "This shouldn't be ran as root." && sleep 2 && exit

# check if in tmux menu
if [ ! "$TMUX" ]; then
    if [ "$1" == '--jon' ]; then
	[ ! "$TMUX" ] && tmux a -t "JonThan:menu" 2>/dev/null || tmux new-session -s "JonThan" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
    else
        [ ! "$TMUX" ] && tmux a -t "Main:menu" || tmux new-session -s  "Main" $0 \; rename-window "menu" \; set mouse on \; 2>/dev/null
    fi
fi

#echo $HOSTNAME
#echo $ID
#echo $IPADDRESS




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

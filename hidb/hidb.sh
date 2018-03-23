#!/bin/bash

echo "
    this is the highdb engine shell.
    Enter the number matching your choise and hit enter to apply them
    To exit totaly, press ctrl+c
    "

function interactiveMode {
	all_done=0
	while (( !all_done )); do
		clear
		select choice in "create database" "use existed database" "exit"
		do
			case $REPLY in
				1) ./createDb.sh database
					break ;;
				2) ./use.sh
					break ;;
				3) all_done=1
					break
					;;
			esac
		done
    done
}

allDone=0
while (( !allDone )); do
	clear
	select choice in "interactive mode" "exit (or press ctrl+c)"
	do
		case $REPLY in
			1) interactiveMode
				break;;
			2) exit
				;;
			*) echo "Look, it's a simple choise..." 
				;;
		esac    
	done
done
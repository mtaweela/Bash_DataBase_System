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
				1) ./create.sh database
					break ;;
				2) ./use.sh
					break ;;
				3) exit
					;;
			esac
		done
    done
}

select choice in "interactive mode" "exit (or press ctrl+c)"
do
    case $REPLY in
       	1) interactiveMode
        	;;
         3) exit
            ;;
	esac    
done

#!/bin/bash

echo "
    this is the highdb engine shell.
    Enter the commands and hit enter to apply them
    To exit press ctrl+c
    "

while true
do
    read -p "> " command

    #eval $command

    case $command in
        create*) 
			./create.sh
            ;;
		insert*) 
			echo insert
			;;
		update*)
			echo update
			;;
		delete*)
			echo delete
			;;
		exit)
			exit
			;;
		*)
			echo "please revise the README file for right syntax"	
			;;
    esac
done

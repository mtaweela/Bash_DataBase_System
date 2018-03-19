#!/bin/bash

# make sure path of the database still exist and is not removed

function CRUD {
	all_done=0
	while (( !all_done )); do
		clear
		# cd `cat ../meta/dbsInfo | grep -w new1: |cut -d":" -f2`/$dbName
		select choice in "Create table" "Update" "Delete" "Exit"
		do
			case $REPLY in
				1) ./createTable.sh
					sleep 2
					break ;;
				2) ./update.sh
					sleep 2
					break ;;
				3) ./delete.sh
					sleep 2
					break ;;
				4) exit
					;;
			esac
		done
    done
}

all_done=0
clear
while (( !all_done )); do
	
	echo "enter name of database you want to use"
	read -p "> " dbName
	
	if cat ../meta/dbsInfo | cut -d":" -f1 | grep -q -w $dbName
	then
		if [ -d `cat ../meta/dbsInfo | grep -w new1: |cut -d":" -f2`/$dbName >/dev/null ]
		then
			CRUD
			break
		else
			echo "
	DB engine can not access the database, 
	Please make sure you did not delete the database"
		fi
	else
		echo "this db does not exist, Please enter name of existing data base"
	fi
done
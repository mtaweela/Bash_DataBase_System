#!/bin/bash

#---------------------------#------------------------#
# list the crud options to use them

function CRUD {
	all_done=0
	while (( !all_done )); do
		clear
		select choice in "Create table" "insert" "Update" "Delete" "Exit"
		do
		# $1 is the path to the database used
			case $REPLY in
				1) ./createTable.sh $1
					break ;;
				2) ./insert.sh $1
					break ;;
				2) ./update.sh $1
					sleep 2
					break ;;
				3) ./delete.sh $1
					sleep 2
					break ;;
				4) exit
					;;
			esac
		done
    done
}

#---------------------------#------------------------#
# start point
# make sure the database exist
# then, access the database if exist

all_done=0
clear
while (( !all_done )); do
	
	echo "enter name of database you want to use"
	read -p "> " dbName
	
	if cat ../meta/dbsInfo | cut -d":" -f1 | grep -q -w $dbName
	then
		if [ -d `cat ../meta/dbsInfo | grep -w $dbName: |cut -d":" -f2`/$dbName ]
		then
			CRUD `cat ../meta/dbsInfo | grep -w $dbName: |cut -d":" -f2`/$dbName
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
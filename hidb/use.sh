#!/bin/bash

# list the existing databases that their metadata exist in the file

cd ..

if [ cut -d: f1 meta/dbsInfo | grep $1 ]
then
	if [ ls $1 ]
	then
		cd databases/$1
	else
		echo "it seems that you deleted the database by wrong"
	fi
else
	echo "please enter name of existing database"	
fi
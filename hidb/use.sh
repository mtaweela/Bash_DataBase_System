#!/bin/bash

if [ -d ../databases/$1 ]
then
	cd ../databases/$1
else
	echo "please enter name of existing database"	
fi

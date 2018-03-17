#!/bin/bash

# This function is used to create database and table
# the vraiable thing either contain table or database


## check db exist
## check table exist
## 

# this line should be removed where the use statment should declare where the database is
cd ../databases


function createDatabase{
	if ! ls $1 2>/dev/null
	then
	   	mkdir "$1"
	elif ls $1 >/dev/null
		echo "database already exists"
	fi
}

function createTable{
	if ! ls $1 2>/dev/null
	then
		touch "$1"
	elif ls $1 >/dev/null
		echo "table already exist"
	fi	
}

if [ $1 = 'database'  ]
then
	createDatabase $*
elif [ $1 = 'table'  ]
then
	createTable $*
else
    echo "error in the sentax. Please see the README file for more information about how to use the function"
fi

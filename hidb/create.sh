#!/bin/bash

# This function is used to create database and table
# the vraiable thing either contain table or database


## check db exist
## check table exist
## 

# this line should be removed where the use statment should declare where the database is

function createNewDB {
    clear
    all_done=0
    while (( !all_done )); do
        echo "Please Enter the name of the new database"
        read dbNewName
        if cat ../meta/dbsInfo | cut -d":" -f1 | grep -q -w $dbNewName
        then
            echo "This database already exist"
        else
            # create the database
            cd $1
            dbpath=`pwd`
            mkdir $dbNewName
            touch $dbNewName/tablesMeta
            cd - >/dev/null
            echo $dbNewName:$dbpath >> ../meta/dbsInfo
            printf "database has been created \n \n"
            all_done=1
        fi
    done
}

function createDatabase {
    all_done=0
    while (( !all_done )); do
        clear
        select choice in "create in the default place" "add your database position" "exit create with out any action"
        do
            case $REPLY in
                1)  createNewDB ../databases
                    break ;;
                2) echo "write the path for your new database"
                    read dbNewPath
                    createNewDB $dbNewPath
                    break ;;
                3) exit
                    break ;;
            esac
        done

        echo "Are we done with creating your database?"
            select opt in "Yes" "No"; do
                    case $REPLY in
                            1) all_done=1; 
                                break ;;
                            2) break ;;
                            *) echo "Look, it's a simple question..." ;;
                    esac
            done
    done
}

function createTable {
    echo "create table1"
}


if [ $1 = 'database'  ]
then
	createDatabase
elif [ $1 = 'table'  ]
then
	createTable
else
    echo "error in the sentax. Please see the README file for more information about how to use the function"
fi
#!/bin/bash

# This function is used to create database and table
# the vraiable thing either contain table or database

#---------------------------#------------------------#
# set the table properties

function setTableSpecs {
    all_done=0
    while (( !all_done )); do
        clear
        echo "enter the new column name"
        read colNmae
        
        echo "are the column values unique"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  unique=1
                    break ;;
                2) unique=0
                    break ;;
            esac
        done

        echo "are the column values not null"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  notNull=1
                    break ;;
                2) notNull=0
                    break ;;
            esac
        done

        echo "what is the data type of the column?"
        select choice in "String" "Number"
        do
            case $REPLY in
                1)  dType=s
                    break ;;
                2) dType=n
                    break ;;
            esac
        done

        echo "Do you need to add another column?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  continue 2 ;;
                2)  break ;;
            esac
        done

        echo "specify pk"
        sleep 2

        # echo "Do you need to add another column?"
        # select choice in "Yes" "No"
        # do
        #     case $REPLY in
        #         1)  break
        #             break ;;
        #         2)  break ;;
        #     esac
        # done
    done
}

#---------------------------#------------------------#
# create table file and call setTableSpecs function

function createTableFile {
    echo $tName"{}" >> $1/tablesMeta
    touch $1/data/$tName
    printf "table has been created \n \n"
    setTableSpecs $1
}

#---------------------------#------------------------#
# check table existence, create table file, set table entry in the meta file

# $1 is the database path
function checkTableExistence {
    clear
    all_done=0
    while (( !all_done )); do
        echo "Please Enter the name of the new table"
        read -p "> " tName
        if cat $1/tablesMeta | cut -d"{" -f1 | grep -q -w $tName
        then
            echo "This table already exist"
        else
            export tName
            createTableFile $1
            all_done=1
        fi
    done
}

#---------------------------#------------------------#
# set the table name

function setTableName {
    all_done=0
# $1 is the database path
    while (( !all_done )); do
        clear
        select choice in "set table name" "exit"
        do
            case $REPLY in
                1)  checkTableExistence $1
                    break ;;
                2) exit
                    break ;;
            esac
        done

        echo "Do you want to create another table?"
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

#---------------------------#------------------------#
# start point

setTableName $1
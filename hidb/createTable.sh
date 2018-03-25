#!/bin/bash

# This script is used to create table

# $1 usually has the path for the database

# table name and its columns will be stored in the following form
# tableName#ColumnName:pk:null:dataType
# columnName : string has the column name
# pk : number that could be 0 or1 or 2 
#       0 --> not unique
#       1 --> unique
#       2 --> primary key
# null : either 1 or 0
#       0 --> could be null
#       1 --> not null
# datatype : either 0 or 1
#       0 --> string 
#       1 --> number


#---------------------------#------------------------#
# set the table properties and save them in the table meta file

function setTableSpecs {
    all_done3=0
    while (( !all_done3 )); do
        clear
        echo "Enter the new column name"
        read  -p "> " colNmae
        
        echo "Is the column values unique?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  pk=1
                    break ;;
                2) pk=0
                    break ;;
            esac
        done

        echo "could the column values be null?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1) nullness=0
                    break ;;
                2) nullness=1
                    break ;;
            esac
        done

        echo "Choose data type for the column"
        select choice in "String" "Number"
        do
            case $REPLY in
                1)  dType=0
                    break ;;
                2) dType=1
                    break ;;
            esac
        done

        echo "Do you need to add another column?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  continue 2 ;; # could cause problem, need check
                2)  break ;;
            esac
        done

        echo "specify pk"
        sleep 2

        all_done3=1
    done
}

#---------------------------#------------------------#
# create table file and call setTableSpecs function

function createTableFile {
    setTableSpecs $1
    echo tSpecs >> $1/tablesMeta
    touch $1/data/$tName
    printf "table has been created \n \n"
}

#---------------------------#------------------------#
# check table existence, create table file, set table entry in the meta file

# $1 is the database path
function checkTableExistence {
    clear
    all_done2=0
    while (( !all_done2 )); do
        echo "Please Enter the name of the new table"
        read -p "> " tName
        if cat $1/tablesMeta | cut -d"{" -f1 | grep -q -w $tName
        then
            echo "This table already exist"
        else
            export tName
            createTableFile $1
            all_done2=1
        fi
    done
}

#---------------------------#------------------------#
# set the table name

function setTableName {
    all_done1=0
# $1 is the database path
    while (( !all_done1 )); do
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

        clear
        select opt in "Create another table" "Exist table creation"; do
                case $REPLY in
                        1) break ;;
                        2) all_done1=1; 
                            break ;;
                        *) echo "Look, it's a simple question..." ;;
                esac
        done
    done
}

#---------------------------#------------------------#
# start point

setTableName $1
tSpecs="" 
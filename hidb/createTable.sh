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
# set the column name

function setColName {
    all_done4=0
    echo "Enter the new column name"
    while (( !all_done4 ))
    do
        read  -p "> "
        if [[ $REPLY =~ [^a-zA-Z_0-9] ]]; then
            echo "Sorry, you can use letters and numbers only in column name"
        elif [[ -z $REPLY ]]
        then
            echo "You should secify name"
        else
            if [ "$REPLY" = "ID" ]
            then
                echo "ID is reserved keyword, PLease choose another word"
            else
                for var in ${colName[@]}
                do
                    if [ "$REPLY" = "$var" ]
                    then
                        echo "This column already exists, Enter another name"
                        continue 2
                    fi
                done
                colName[$1]=$REPLY # $1 here is the index i from the calling function
                all_done4=1
            fi
        fi
    done
}

#---------------------------#------------------------#
# set the table properties and save them in the table meta file

function setTableSpecs {
    all_done3=0
    i=0
    while (( !all_done3 )); do
        clear
        setColName $i

        echo "Are the column values unique?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  pk[$i]=1
                    break ;;
                2)  pk[$i]=0
                    break ;;
            esac
        done

        echo "could the column values be null?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1) nullness[$i]=0
                    break ;;
                2) nullness[$i]=1
                    break ;;
            esac
        done

        echo "Choose data type for the column"
        select choice in "String" "Number"
        do
            case $REPLY in
                1)  dType[$i]=0
                    break ;;
                2) dType[$i]=1
                    break ;;
            esac
        done

        echo "Do you need to add another column?"
        select choice in "Yes" "No"
        do
            case $REPLY in
                1)  ((i++))
                    continue 2 ;; # could cause problem, need check
                2)  break ;;
            esac
        done

        select choice in "Specify primery key" "Keep the default primary key"
        do
            case $REPLY in
                1)  # check for the nullness and uniqness
                    select opt in ${colName[*]}; do 
                        case $REPLY in
                            [1-${#colName[@]}]) echo "You picked $opt"
                                IDpk=1 # this indicate that the ID is unique but not pk
                                pk[$REPLY]=2
                                break;;
                            *) echo "Invalid option. Try another one." 
                                continue;;
                        esac
                    done
                    break ;;
                2) IDpk=2 # indicate that the ID is pk
                    break ;;
            esac
        done

        # concatenate here
        tSpecs=$tName"#ID:"$IDpk":1:1"

        j=0
        while ((j<${#colName[@]}))
        do
            tSpecs=$tSpecs";"${colName[$j]}":"${pk[$j]}":"${nullness[$j]}":"${dType[$j]}
            ((j++))
        done
        echo $tSpecs >>$1/tablesMeta

        all_done3=1
    done
}

#---------------------------#------------------------#
# create table file and call setTableSpecs function

function createTableFile {
    setTableSpecs $1
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
        read -p "> "
        if [[ $REPLY =~ [^a-zA-Z_0-9] ]]; then
            echo "Sorry, you can use letters and numbers only in table name"
        elif [[ -z $REPLY ]]
        then
            echo "You should secify name"
        else
            if cat $1/tablesMeta | cut -d"#" -f1 | grep -q -w $REPLY
            then
                echo "This table already exists"
            else
                tName=$REPLY
                export tName
                createTableFile $1
                all_done2=1
            fi
        fi
    done
}

#---------------------------#------------------------#
# set the table name

# $1 is the database path
function setTableName {
    all_done1=0
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
        select opt in "Create another table" "Exit table creation"; do
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

# $1 is the database path
setTableName $1
tSpecs="" 
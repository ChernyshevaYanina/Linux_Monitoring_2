#!/bin/bash


if [[ "$#" != 6 ]]
then
    echo "Invalid numbers of parameters"
    exit 1
fi

if [[ ! "$path" = "/"* ]]
then
    echo "First parameter must be absolute path"
    exit 1
fi

if [[ ! "$dir_num" =~ ^[0-9]+([.][0-9]+)?$ ]]
then
    echo "Second parameter must be integer"
    exit 1
fi

if [[ ! "$dir_alph" =~ ^[a-zA-Z]{1,7}$ ]]
then
    echo "Letters for folders must contain from 1 to 7 characters"
    exit 1
fi

if [[ ! "$file_num" =~ ^[0-9]+$ ]]
then 
    echo "Forth parameter must be integer"
    exit 1
fi

if [[ ! "$file_alph" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]
then
    echo "Letters for files must contain 1 to 7 characters for name and from 1 to 3 characters ащк extension"
    exit 1
fi

if [[ ! "$file_size" =~ ^[1-9][0-9]?[0]?kb$ ]]
then 
    echo "Sixth parameter must be integer"
    exit 1
else 
    file_size=$(echo $file_size | awk -F"kb" '{print $1}')
fi

if [[ $file_size -gt 100 ]]
then
    echo "File size must be no more then 100"
    exit 1
fi

if [[ $(df -m / | awk 'NR==2{print $4}') -le 1024 ]]
then
    echo "Not enough space"
    exit 1
fi

. ./creation.sh
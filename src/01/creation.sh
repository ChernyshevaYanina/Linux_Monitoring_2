#!/bin/bash

log=./file.log
echo "Path, Date, Size" > $log

date=$(date '+%d%m%y')
source name.sh

function start_dir {
    for (( i=0; i<$dir_num; i++ ))
    do
        dir_name=""
        create_dir_name 
    done
}

function create_dir_name {
    letter=$dir_alph
    renge=$(echo $(( $RANDOM % 100 + 10)))
    while [[ ${#letter} -lt renge ]]
    do
        make_name $letter
    done
    dir_name=$letter
    dir_name+="_${date}"
    mkdir -p "${path}/${dir_name}"
    echo "$(realpath ${path}/${dir_name}), $(date +%Y-%m-%d), directory" >> $log
}


function start_file {
    for dir in $(find $path -maxdepth 1 -mindepth 1 -type d)
    do
        dir_name=$(basename $dir)
        for (( i=0; i<$file_num; i++ ))
        do
            file_name=""
            create_file_name
        done
    done
}

function create_file_name {
    letter=$(echo $file_alph | awk -F "." '{print $1}')
    range=$(echo $(( $RANDOM % 100 + 10)))
    while [[ ${#letter} -lt $range ]]
    do
        make_name $letter
    done
    file_name=$letter
    file_name+="."
    file_name+=$(echo $file_alph | awk -F "." '{print $2}')
    file_name+="_${date}"
    if [[ $(df -m / | awk 'NR==2{print $4}') -le 1024 ]]
    then
        echo "Not enough space"
        exit 1
    else 
        fallocate -l ${file_size}kB "${dir}/${file_name}"
        echo "$(realpath ${dir}/${file_name}), $(date +%Y-%m-%d), $(stat --format="%s" ${dir}/${file_name})b" >> $log
    fi
}


start_dir
start_file

echo "Done!"
exit 0
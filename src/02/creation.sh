#!/bin/bash
log=./file.log
echo "Path, Date, Size" > $log

date=$(date '+%d%m%y')

start_t=$(date '+%Y-%m-%d %H:%M:%S')
echo "Script started at ${start_t}"
echo "Script started at ${start_t}" >> $log

source name.sh

function gen_path {
    path=$(find "/" -type d -maxdepth 5 2>/dev/null | shuf -n 1 )
    while [[ $? -ne 0 ]]
    do 
        path=$(find "/" -type d -maxdepth 5 2>/dev/null | shuf -n 1 )
    done
}

function start_dir {
    for (( i=0; i<100; i++ ))
    do
        gen_path
        dir_name=""
        create_dir_name
    done
}

function create_dir_name {
    letter=$dir_alph
    renge=$(echo $(($RANDOM%100+10)))
    while [[ ${#letter} -lt renge ]]
    do
        make_name $letter
    done
    dir_name=$letter
    dir_name+="_${date}"
    mkdir -m +x "${path}/${dir_name}" 2>/dev/null
    if [[ $? -eq 0 && $free_space -gt 1024 ]]
    then
        echo "$(realpath ${path}/${dir_name}), $(date +%Y-%m-%d), directory" >> $log
        start_file
    fi
}

function start_file {
        for (( i=0; i<$(($RANDOM%50+10)); i++ ))
        do 
            free_space=$(df -m / | awk 'NR==2{print $4}')
            if [[ $free_space -gt 1024 ]]
            then
                file_name=""
                create_file_name
            fi
        done
}

function create_file_name {
    letter=$(echo $file_alph | awk -F "." '{print $1}')
    range=$(echo $(($RANDOM%100+10)))
    while [[ ${#letter} -lt $range ]]
    do
        make_name $letter
    done
    file_name=$letter
    file_name+="."
    file_name+=$(echo $file_alph | awk -F "." '{print $2}')
    file_name+="_${date}"
    file_path="${path}/${dir_name}/${file_name}"
    if [[ $free_space -gt 1024 ]]
    then
        fallocate -l ${file_size}M ${file_path} 2>/dev/null
        create_log ${file_path}
    else
        create_log_end
    fi

}

function create_log {
    file_path=$1
    size_in_bytes=$(stat -c%s ${file_path})
    size_in_mb=$(echo "scale=2;$size_in_bytes/1024/1024" | bc)
    create_date=$(date "+%Y-%m-%d %H:%M" -r "${file_path}")
    echo "${file_path}, ${create_date}, ${size_in_mb} MB" >> $log
}

function space {
    free_space=$(df -m / | awk 'NR==2{print $4}')
    while [[ $free_space -gt 1024 ]]
    do
        start_dir
        free_space=$(df -m / | awk 'NR==2{print $4}')
    done
    create_log_end
}

function create_log_end {
    end_t=$(date '+%Y-%m-%d %H:%M:%S')
    echo "Script finished at ${end_t}"
    echo "Script finished at ${end_t}" >> $log

    run_t=$(($(date -d "$end_t" '+%s') - $(date -d "$start_t" '+%s')))
    echo "Run time: ${run_t} seconds"
    echo "Run time: ${run_t} seconds" >> $log

    echo "Done!"
    exit 0
}

space
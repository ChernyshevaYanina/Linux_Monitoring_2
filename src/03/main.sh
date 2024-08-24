#!/bin/bash
. ./check.sh

if [ $1 -eq 1 ]
then
    echo "Enter log file path: "
    read LOG_PATH

    while read line
    do
        path=$(echo $line | cut -d ',' -f 1)
        rm -rf $path
    done < $LOG_PATH

elif [ $1 -eq 2 ]
then
    echo "Enter date start"
    echo "Example: YYYY-MM-DD HH:MM"
    read from_date from_time
    echo "Enter date end"
    echo "Example: YYYY-MM-DD HH:MM"
    read to_date to_time

    find / -newermt "$from_date $from_time" ! -newermt "$to_date $to_time" -delete 2>/dev/null


elif [ $1 -eq 3 ]
then
    echo "Enter name mask: "
    read mask

    find / -type f -name "*$mask*" -delete 2>/dev/null
    find / -type d -name "*$mask*" -exec rm -rf {} \; 2>/dev/null
fi

echo "Complete"
exit 0

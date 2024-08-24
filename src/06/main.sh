#!/bin/bash

if [ $# -ne 0 ]
then
    echo "Invalid number of arguments"
    exit 1
else
    for i in {1..5}; do
        goaccess ../04/log/access_log_$i.log --log-format=COMBINED > index.html
    done
fi

exit 0

#!/bin/bash

if [[ $# -ne 1 || ($1 -ne 1 && $1 -ne 2 && $1 -ne 3 && $1 -ne 4) ]]
then
    echo "Enter 1, 2, 3 or 4, where"
    echo "1 - sorted by response code"
    echo "2 - sorted by unique IP addresses found in the records"
    echo "3 - sorted by requests with errors (response code - 4xx or 5xx)"
    echo "4 - sorted by unique IP addresses that occur among erroneous requests"
    exit 1
fi
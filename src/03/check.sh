#!/bin/bash

if [[ $# -ne 1 || ($1 -ne 1 && $1 -ne 2 && $1 -ne 3) ]]
then
    echo "Enter 1, 2, or 3, where"
    echo "1 - clean by log file"
    echo "2 - clean by creation time"
    echo "3 - clean by name mask"
    exit 1
fi

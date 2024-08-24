#!/bin/bash
. ./check.sh

log_dir="../04/log"

rm -f error.log unique_IP.log error_4xx_5xx.log unique_IP_err.log

for i in {1..5}; do
    log_file="${log_dir}/access_log_$i.log"

    if [[ "$1" == "1" ]]; then
        awk '{print $9 "\t" $0}' "$log_file" | sort -n | cut -f 2- >> error.log
        sort -k 9 "error.log" -o "error.log"
    fi

    if [[ "$1" == "2" ]]; then
        awk '{print $1 "\t" $0 }' "$log_file" | sort -u | cut -f 2 >> unique_IP.log
        sort -k 1 "unique_IP.log" -o "unique_IP.log"
    fi

    if [[ "$1" == "3" ]]; then
        awk '{if ($9 ~ /^4/ || $9 ~ /^5/) print}' "$log_file" >> error_4xx_5xx.log
    fi

    if [[ "$1" == "4" ]]; then
        awk '{if ($9 ~ /^4/ || $9 ~ /^5/) print}' "$log_file" | sort -u >> unique_IP_err.log
        sort -k 1 "unique_IP_err.log" -o "unique_IP_err.log"
    fi
done

echo "Complete"
exit 0

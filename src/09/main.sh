#!/bin/bash
if [ $# -ne 0 ]
then 
    echo "Invalid numbers of parameters"
fi

cp nginx.conf /etc/nginx/
sudo systemctl reload nginx
cp prometheus.yml /etc/prometheus/
sudo systemctl reload prometheus

while true
do
    cpu="$(cat /proc/stat | head -1 | awk '{print $4}')"
    memofree="$(cat /proc/meminfo | awk '/MemFree/{print $2*1024}')"
    diskfree="$(df -h / | tail -1 | awk '{print $4*1024}')"
{
    echo "cpu_system_seconds "$cpu"
memory_free_bytes "$memofree"
filesystem_free_bytes "$diskfree""
} > metrix.html
    sleep 5
done 

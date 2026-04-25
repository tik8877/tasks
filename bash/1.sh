#!/bin/bash

file=$1
time=$2

for ((i=0; i<time; i++))
do
    load=$(cat /proc/loadavg)
    date_str=$(date "+%d.%m.%y %H:%M")
    echo "$date_str = $load" >> "$file"
    sleep 1
done


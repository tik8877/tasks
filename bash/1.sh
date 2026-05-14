#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Specify the file name and timeframe as arguments!"
    exit 1
fi

file_name=$1
timeframe=$2

if ! [[ "$timeframe" =~ ^[0-9]+$ ]] || [ "$timeframe" -le 0 ]; then
    echo "The timeframe must be positive!"
    exit 1
fi

> "$file_name"

for ((i=0; i<timeframe; i++)); do
    current_time=$(date +"[ %d.%m.%y %H:%M ]")
    loadavg=$(cat /proc/loadavg)
    echo "$current_time = $loadavg" >> "$file_name"
    sleep 1
done

echo "End of script. Data saved to $file_name."



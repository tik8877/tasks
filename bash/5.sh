#!/bin/bash

if [ ! -d "/var/log" ]; then
    echo "The directory /var/log does not exist!"
    exit 1
fi

> logs.log

for file in /var/log/*.log; do
    if [ -f "$file" ]; then
        last_line=$(tail -n 1 "$file")
        if [ -n "$last_line" ]; then
            echo "$last_line" >> logs.log
        else
            echo "The file is empty." >> logs.log
        fi
    fi
done

if [ -s logs.log ]; then
    echo "End of script. Results are recorded in logs.log."
else
    echo "Files not found or empty."
    exit 1
fi


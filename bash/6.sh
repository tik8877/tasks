#!/bin/bash

if [ "$FOO" = "5" ] && [ "$BAR" = "1" ]; then
    echo "Runtime error due to environment variables."
    exit 1
fi

filename="fix.txt"

while true; do
    if [ -e "$filename" ]; then
        echo "End of script. A new file has appeared in $(pwd)"
        exit 0
    fi
    sleep 0.1
done


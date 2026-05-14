#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify at least one file!"
    exit 1
fi

for file in "$@"; do
    if [ -f "$file" ]; then
        count=$(wc -l < "$file")
        echo "$file => $count"
    else
        echo "$file => not found"
    fi
done


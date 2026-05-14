#!/bin/bash

IFS=':' read -ra DIRS <<< "$PATH"
declare -A seen

for dir in "${DIRS[@]}"; do
    if [[ -n "${seen[$dir]}" ]]; then
        continue
    fi
    seen[$dir]=1

    if [[ -d "$dir" ]]; then
        count=$(find "$dir" -maxdepth 1 -type f ! -name ".*" | wc -l)
        echo "$dir=>$count"
    fi
done



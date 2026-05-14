#!/bin/bash

lc_vars=$(env | grep '^LC_')

if [ -z "$lc_vars" ]; then
    echo "LC_ variables not found!"
    exit 0
fi

first_value=""
is_different=false

while IFS= read -r line; do
    value=${line#*=}
    if [ -z "$first_value" ]; then
        first_value="$value"
    elif [ "$value" != "$first_value" ]; then
        is_different=true
    fi
done <<< "$lc_vars"

if [ "$is_different" = "true" ]; then
    echo "LC_ variables have different values!"
    echo "$lc_vars"
    exit 1
else
    echo "All LC_ variables have the same value: $first_value"
    exit 0
fi


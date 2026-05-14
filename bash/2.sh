#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Specify the path to the directory as an argument!"
    exit 1
fi

path=$1
if [ ! -d "$path" ]; then
    echo "The path does not exist or is not a directory."
    exit 1
fi

cd "$path" || exit 1

for dir in */; do
    if [ -d "$dir" ]; then
        dir_name=$(basename "$dir")
        count=$(ls -l "$dir" | wc -l)
        count=$((count - 1))
        echo "$count" > "$dir_name"
    fi
done

echo "End of script. Files saved to $path"

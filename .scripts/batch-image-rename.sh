#!/bin/bash
for file in *; do
    # Only check for files probably?
    if [ -f "$file" ]; then
        feh -. $file &
        feh_pid=$!
        echo "Enter new filename (no file extension) or type d to delete the file:"
        read new_name
        if [ "$new_name" = "d" ]; then
            rm $file
            kill $feh_pid
            continue
        fi
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        new_filename="$new_name.$extension"
        # Wait until we choose a filename that doesn't exist
        while [ -f "$new_filename" ]; do
            echo "File already exists!"
            read new_name
            filename=$(basename -- "$file")
            extension="${filename##*.}"
            new_filename="$new_name.$extension"
        done
        mv $file "$new_name.$extension"
        # End displayed feh window so we can start the new one.
        kill $feh_pid
    fi
done

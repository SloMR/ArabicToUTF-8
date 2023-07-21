#!/bin/bash
set -euo pipefail

# Function to print usage
function usage() {
    echo "Usage: $0 <folder_path>"
    echo "e.g. $0 /Movies/MyMovie"
    exit 1
}

# Check that the user has provided the correct number of arguments
if [ $# -lt 1 ]; then
    usage
fi

FOLDER_PATH=$1 # e.g. /Movies/MyMovie

# Check that the user has provided the correct arguments
function check_input() {
    if [[ -z "$FOLDER_PATH" ]]; then
        echo "Please provide a folder path as an argument"
        exit 1
    fi

    if [[ ! -d "$FOLDER_PATH" ]]; then
        echo "Folder does not exist"
        exit 1
    fi
}

# Convert all files in a folder to UTF-8 encoding
# e.g. WINDOWS-1256 -> UTF-8
function subtitle_convert() {
    check_input
    echo "Converting all files in '$FOLDER_PATH' to UTF-8 encoding"

    find "$FOLDER_PATH" -type f -print0 | while IFS= read -r -d '' file; do
        if [[ $file == *.srt ]]; then
            charset="$(file -bi "$file" | awk -F "=" '{print $2}')"
            if [ "$charset" != utf-8 ]; then
                iconv -cf WINDOWS-1256 -t utf-8 "$file" >"$file.new" &&
                    mv -f "$file.new" "$file" &&
                    echo "$file"
            fi
        fi
    done

    exit 0
}

subtitle_convert

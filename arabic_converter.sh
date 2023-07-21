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

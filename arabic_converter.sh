#!/bin/bash
set -euo pipefail

# Function to print usage
function usage() {
    echo "Usage: $0 <folder_path>"
    echo "e.g. $0 /Movies/MyMovie"
    exit 1
}
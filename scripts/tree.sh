#!/bin/bash

ignorefile=.treeignore

# Check if WORKDIR is set
if [ -n "$WORKDIR" ]; then
    # Change to the WORKDIR directory
    cd "$WORKDIR" || { echo "Error: Unable to change to directory $WORKDIR"; exit 1; }
fi

# Check if a directory path is provided as an argument
if [ "$#" -eq 1 ]; then
    dirpath="$1"
else
    dirpath="."
fi

# Function to process ignore patterns
process_ignore_patterns() {
    grep -v '^#' "$1" | grep -v '^$' | sed 's/\*\*\///' | tr '\n' '|' | sed 's/|$//'
}

# Check if the $ignorefile exists in the specified directory
if [ -f "$dirpath/$ignorefile" ]; then
    ignore_patterns=$(process_ignore_patterns "$dirpath/$ignorefile")
    echo "Debug: Ignore patterns: $ignore_patterns"
    echo "Debug: Running tree command:"
    echo "tree -a -I \"$ignore_patterns\" \"$dirpath\""
    # Run tree command with ignore patterns
    tree -a -I "$ignore_patterns" "$dirpath"
else
    echo "$ignorefile not found in $dirpath. Running tree without ignore patterns."
    # If .treeignore is not found, run tree without ignore patterns
    tree -a "$dirpath"
fi

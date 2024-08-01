#!/bin/bash

ignorefile=.treeignore
dirpath="${1:-.}"

echo "Debug: Using directory: $dirpath"
echo "Debug: Looking for ignore file: $dirpath/$ignorefile"

if [ ! -f "$dirpath/$ignorefile" ]; then
    echo "Error: $ignorefile file not found in the directory $dirpath."
    exit 1
fi

# Read ignore patterns from .treeignore and process them
ignore_patterns=$(grep -v '^#' "$dirpath/$ignorefile" | grep -v '^$' | sed 's/\*\*\///' | tr '\n' '|' | sed 's/|$//')

echo "Debug: Ignore patterns: $ignore_patterns"

echo "Debug: Running tree command:"
echo "tree -a -I \"$ignore_patterns\" \"$dirpath\""

# Run tree command with ignore patterns
tree -a -I "$ignore_patterns" "$dirpath"
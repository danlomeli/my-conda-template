#!/bin/bash

ignorefile=.catignore

# Debug: Print script name and arguments
# echo "Debug: Running $(basename "$0") $*"

# Check if a directory path is provided as an argument
if [ "$#" -eq 1 ]; then
    dirpath="$1"
else
    dirpath="."
fi

# Debug: Print the directory being used
# echo "Debug: Using directory: $dirpath"

# Debug: Print the ignore file being looked for
# echo "Debug: Looking for ignore file: $dirpath/$ignorefile"

# Check if the $ignorefile exists in the specified directory
if [ ! -f "$dirpath/$ignorefile" ]; then
    echo "Error: $ignorefile file not found in the directory $dirpath."
    exit 1
fi

# Debug: Print the contents of the ignore file
# echo "Debug: Ignore patterns:"
# cat "$dirpath/$ignorefile"

# Enable shell options for handling wildcards and hidden files
shopt -s nullglob dotglob

# Function to check if a file should be ignored
should_ignore() {
    local file="$1"
    local pattern
    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
        [[ -z "$pattern" || "$pattern" == \#* ]] && continue
        if [[ "$file" == $pattern || "$file" == */$pattern ]]; then
            return 0
        fi
    done < "$dirpath/$ignorefile"
    return 1
}

# Debug: Print the start of file processing
# echo "Debug: Starting file processing"

# Find all files in the specified directory and its subdirectories
find "$dirpath" -type f | while IFS= read -r file; do
    if ! should_ignore "${file#./}"; then
        if [ -f "$file" ] && ! file --mime "$file" | grep -q 'binary'; then
            echo -e "\n********\nFilename: $file\nContent:\n"
            cat "$file"
        fi
    # else
    #     # Debug: Print ignored files
    #     echo "Debug: Ignoring file: $file"
    fi
done

# Debug: Print the end of file processing
# echo "Debug: File processing complete"
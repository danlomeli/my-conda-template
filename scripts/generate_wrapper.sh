#!/usr/bin/env bash

# Get the path to the Python environment from an environment variable
PYENV_ROOT=${PYENV_ROOT:-"$HOME/.pyenv"}

# Get the name of the CLI tool from an environment variable or use a default value
TOOL_NAME=${TOOL_NAME:-"my-tool"}

# Generate the wrapper script
cat > "$TOOL_NAME" <<EOL
#!/usr/bin/env bash

set -e
[ -n "\$PYENV_DEBUG" ] && set -x
program="\${0##*/}"
export PYENV_ROOT="$PYENV_ROOT"
exec "\$PYENV_ROOT/libexec/pyenv" exec "\$program" "\$@"
EOL

# Make the wrapper script executable
chmod +x "$TOOL_NAME"

echo "Wrapper script '$TOOL_NAME' generated successfully."
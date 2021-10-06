#!/bin/bash

# Initialize CCache if it will be used
if [ "$USE_CCACHE" = 1 ]; then
  ccache -M "$CCACHE_SIZE" 2>&1
fi

# Initialize Git user information
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_MAIL"

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="bash"
fi

exec $args
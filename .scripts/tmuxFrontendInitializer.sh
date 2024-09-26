#!/bin/bash

# Check if a session name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <session-name>"
  exit 1
fi

# Assign the first argument to session_name
SESSION_NAME=$1

# Start a new tmux session with the given name, but do not attach yet
tmux new-session -d -s "$SESSION_NAME" -n "nvim"

# Create new windows in the specified order
tmux new-window -t "$SESSION_NAME":2 -n "servers"
tmux split-window -h -t "$SESSION_NAME":2

tmux new-window -t "$SESSION_NAME":4 -n "zsh"
tmux new-window -t "$SESSION_NAME":5 -n "git"

tmux select-window -t "$SESSION_NAME":1

# Attach to the session
tmux attach-session -t "$SESSION_NAME"

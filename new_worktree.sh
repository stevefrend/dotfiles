#!/bin/bash

# Check if name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <branch name>"
  exit 1
fi

# Assign the arguments to variables
BRANCH=$1

# Create a new worktree with the given folder and branch
git worktree add "$BRANCH" -b "$BRANCH"

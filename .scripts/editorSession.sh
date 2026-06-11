#!/bin/bash
#
# General editor tmux session.
# Window layout: 1 nvim | 2 claude + `hunk diff` (split) | 3 lazygit | 4 zsh | 5 zsh
#
# Usage:  editorSession.sh [session-name]
#   session-name defaults to the current directory's basename, so you can run it
#   in any project. If the session already exists, it just (re)attaches.
#
# Wired to the `edit` alias in .zshrc.

set -euo pipefail

START_DIR="$PWD"
SESSION_NAME="${1:-$(basename "$START_DIR")}"
# tmux forbids '.' and ':' in session names — sanitize to '_'.
SESSION_NAME="${SESSION_NAME//[.:]/_}"

# Build the session only if it doesn't already exist.
if ! tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
  # `<app>; exec zsh` runs the app, then drops to an interactive shell on exit
  # (so quitting nvim / an empty `hunk diff` leaves a usable shell, not a dead pane).
  tmux new-session   -d -s "$SESSION_NAME" -c "$START_DIR" -n nvim    'nvim; exec zsh'
  # Window 2: claude (left) + `hunk diff` (right), claude focused.
  tmux new-window    -t "$SESSION_NAME":2  -c "$START_DIR" -n claude  'claude; exec zsh'
  tmux split-window  -h -t "$SESSION_NAME":2 -c "$START_DIR"          'hunk diff; exec zsh'
  tmux select-pane   -t "$SESSION_NAME":2 -L
  tmux new-window    -t "$SESSION_NAME":3  -c "$START_DIR" -n lazygit 'lazygit; exec zsh'
  tmux new-window    -t "$SESSION_NAME":4  -c "$START_DIR" -n zsh
  tmux new-window    -t "$SESSION_NAME":5  -c "$START_DIR" -n zsh
  tmux select-window -t "$SESSION_NAME":1
fi

# Attach, or switch if we're already inside tmux.
if [ -n "${TMUX:-}" ]; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux attach-session -t "$SESSION_NAME"
fi

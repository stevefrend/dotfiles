#!/usr/bin/env bash
set -euo pipefail

# Bootstrap a machine straight from the repo with ansible-pull.
#   ./ansible-pull.sh                       # foundations from the default repo
#   ./ansible-pull.sh <repo-url> foundations
#   ./ansible-pull.sh <repo-url> neovim,git

REPO_URL="${1:-https://github.com/stevefrend/dotfiles.git}"
TAGS="${2:-foundations}"

if ! command -v ansible-pull &>/dev/null; then
  echo "Installing Ansible..."
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install ansible
  elif command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y ansible
  else
    echo "Unsupported OS. Install Ansible manually and re-run."
    exit 1
  fi
fi

PULL_DIR="$HOME/.ansible-pull/dotfiles"

echo "Running ansible-pull with tags: $TAGS"
ansible-pull \
  --url "$REPO_URL" \
  --directory "$PULL_DIR" \
  --only-if-changed \
  --extra-vars "dotfiles_dir=$PULL_DIR" \
  --tags "$TAGS"

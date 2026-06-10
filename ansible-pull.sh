#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:-https://github.com/stevefrend/dotfiles.git}"
TAGS="${2:-dev}"
LOCATION="${3:-home}"

if ! command -v ansible-pull &> /dev/null; then
  echo "Installing Ansible..."
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install ansible
  elif command -v apt &> /dev/null; then
    sudo apt update && sudo apt install -y ansible
  else
    echo "Unsupported OS. Install Ansible manually and re-run."
    exit 1
  fi
fi

echo "Running ansible-pull with tags: $TAGS (location: $LOCATION)"
ansible-pull \
  --url "$REPO_URL" \
  --directory "$HOME/.ansible-pull/dotfiles" \
  --only-if-changed \
  --extra-vars "location=$LOCATION" \
  --tags "$TAGS"

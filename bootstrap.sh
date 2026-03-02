#!/usr/bin/env bash
# Bootstrap a fresh macOS or Linux machine with dotfiles.
# Usage: ./bootstrap.sh [ansible-playbook options]
#   e.g. ./bootstrap.sh --tags dotfiles
#        ./bootstrap.sh --check

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() { echo ""; echo "==> $*"; }

# ── 1. System prerequisites (Linux only) ──────────────────────────────────────
if [[ "$(uname -s)" == "Linux" ]]; then
  step "Installing system prerequisites (apt)..."
  sudo apt-get update -qq
  sudo apt-get install -y --no-install-recommends \
    curl git build-essential zsh file procps python3 python3-pip unzip
fi

# ── 2. Homebrew ────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  step "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for this shell session
  if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  step "Homebrew already installed, skipping."
fi

# ── 3. Ansible ────────────────────────────────────────────────────────────────
if ! command -v ansible &>/dev/null; then
  step "Installing Ansible via Homebrew..."
  brew install ansible
fi

# ── 4. Ansible Galaxy collections ─────────────────────────────────────────────
step "Installing Ansible collections..."
ansible-galaxy collection install -r "${SCRIPT_DIR}/ansible/requirements.yml" --upgrade

# ── 5. Run the playbook ───────────────────────────────────────────────────────
step "Running Ansible playbook..."
ansible-playbook \
  -i "${SCRIPT_DIR}/ansible/inventory/localhost.yml" \
  "${SCRIPT_DIR}/ansible/setup.yml" \
  "$@"

step "Bootstrap complete! Restart your terminal or run: exec zsh"

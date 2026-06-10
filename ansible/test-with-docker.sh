#!/usr/bin/env bash
set -euo pipefail

DISTRO="${1:-debian:bookworm}"
TAGS="${2:-minimal}"

echo "==> Testing Ansible dotfiles on $DISTRO with tags: $TAGS"
echo ""

docker run --rm -i \
  --platform linux/amd64 \
  -v "$(dirname "$PWD")":/dotfiles:ro \
  "$DISTRO" \
  bash -c "
    set -euo pipefail

    # Install Ansible and dependencies
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    apt-get install -y -qq ansible curl git sudo > /dev/null 2>&1

    # Create a non-root user for testing
    useradd -m testuser
    echo 'testuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
    chown -R testuser:testuser /dotfiles

    # Run playbook in check mode as testuser
    sudo -u testuser DOTFILES_DIR=/dotfiles ansible-playbook /dotfiles/ansible/playbook.yml \
      --inventory /dotfiles/ansible/inventory.yml \
      --tags $TAGS \
      --check \
      --diff

    echo ''
    echo '==> Check mode completed successfully'
"

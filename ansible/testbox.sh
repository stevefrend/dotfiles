#!/usr/bin/env bash
set -euo pipefail

# Lightweight Debian testbox for the dotfiles playbook.
#
# Runs ansible *inside* a single throwaway container over a local connection —
# no sshd, no privileged caps, native arch. It's just one more small container,
# so it won't take colima (or your other containers) down.

DIR="$(cd "$(dirname "$0")" && pwd)"
REPO="$(dirname "$DIR")"
NAME="dotfiles-testbox"
IMAGE="dotfiles-testbox"

exec_dev() { docker exec -u dev "$NAME" "$@"; }

case "${1:-}" in
  up)
    echo "==> Building $IMAGE (native arch)..."
    docker build -t "$IMAGE" -f "$DIR/Dockerfile.testbox" "$DIR"
    echo "==> Starting $NAME..."
    docker rm -f "$NAME" >/dev/null 2>&1 || true
    docker run -d \
      --name "$NAME" \
      --hostname testbox \
      -v "$REPO:/dotfiles:ro" \
      "$IMAGE"
    echo ""
    echo "  Dry run:   $0 check"
    echo "  Apply:     $0 ansible --tags foundations"
    echo "  Shell:     $0 shell"
    echo "  Stop:      $0 down"
    ;;

  down)
    echo "==> Removing $NAME..."
    docker rm -f "$NAME" >/dev/null 2>&1 || true
    ;;

  shell)
    docker exec -it -u dev "$NAME" /bin/bash
    ;;

  ansible)
    shift
    # Default to the foundations base if no tags/args were given.
    if [ "$#" -eq 0 ]; then set -- --tags foundations; fi
    exec_dev env DOTFILES_DIR=/dotfiles ansible-playbook \
      /dotfiles/ansible/playbook.yml \
      -i /dotfiles/ansible/inventory.yml -c local "$@"
    ;;

  check)
    shift
    if [ "$#" -eq 0 ]; then set -- --tags foundations; fi
    exec_dev env DOTFILES_DIR=/dotfiles ansible-playbook \
      /dotfiles/ansible/playbook.yml \
      -i /dotfiles/ansible/inventory.yml -c local --check --diff "$@"
    ;;

  *)
    cat <<EOF
Usage: $0 {up|check|ansible|shell|down}

  up        Build and start the testbox container
  check     Dry-run the playbook (--check --diff) inside the container
  ansible   Apply the playbook inside the container (default: --tags foundations)
  shell     Open a shell inside the container to poke around
  down      Stop and remove the container

Examples:
  $0 up
  $0 check
  $0 ansible --tags foundations
  $0 ansible --tags neovim,git
  $0 shell
  $0 down
EOF
    ;;
esac

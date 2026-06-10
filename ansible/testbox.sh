#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
NAME="dotfiles-testbox"
IMAGE="dotfiles-testbox"
CMD="${1:-}"

case "$CMD" in
  up)
    echo "==> Building $IMAGE..."
    docker build --platform linux/arm64 -t "$IMAGE" -f "$DIR/Dockerfile.testbox" "$DIR"
    echo "==> Starting $NAME..."
    docker rm -f "$NAME" 2>/dev/null || true
    docker run -d \
      --platform linux/arm64 \
      --name "$NAME" \
      --hostname testbox \
      -p 2222:22 \
      -v "$DIR/..:/dotfiles:ro" \
      "$IMAGE"
    echo "==> Waiting for SSH..."
    for i in $(seq 1 15); do
      if docker exec "$NAME" sshd -t 2>/dev/null; then
        break
      fi
      sleep 1
    done
    docker cp "$NAME:/home/testuser/.ssh/id_ed25519" /tmp/testbox_key 2>/dev/null
    chmod 600 /tmp/testbox_key 2>/dev/null
    echo ""
    echo "  SSH:        ssh -i /tmp/testbox_key testuser@localhost -p 2222"
    echo "  Ansible:    $0 ansible --tags minimal"
    echo "  Shell:      $0 shell"
    echo "  Stop:       $0 down"
    ;;

  down)
    echo "==> Stopping $NAME..."
    docker stop "$NAME" 2>/dev/null || true
    docker rm "$NAME" 2>/dev/null || true
    ;;

  shell)
    docker exec -it "$NAME" /bin/bash
    ;;

  ssh)
    shift
    ssh testuser@localhost -p 2222 "$@"
    ;;

  ansible)
    shift
    ansible-playbook "$DIR/playbook.yml" \
      -i "$DIR/inventory.testbox.yml" \
      "$@"
    ;;

  *)
    echo "Usage: $0 {up|down|shell|ssh|ansible}"
    echo ""
    echo "  up        Build and start the testbox container"
    echo "  down      Stop and remove the container"
    echo "  shell     Open a shell inside the container"
    echo "  ssh       SSH into the container"
    echo "  ansible   Run ansible-playbook against the testbox"
    echo ""
    echo "Examples:"
    echo "  $0 up"
    echo "  $0 shell"
    echo "  $0 ansible --tags minimal --diff"
    echo "  $0 ansible --tags dev --check"
    echo "  $0 ansible --tags minimal,docker"
    ;;
esac

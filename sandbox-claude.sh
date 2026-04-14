#!/usr/bin/env sh
IMAGE="claude-sandbox"
DOCKERFILE="Dockerfile.sandbox"
FORCE_REBUILD=0

for arg in "$@"; do
  case "$arg" in
    -f|--force-rebuild)
      FORCE_REBUILD=1
      ;;
    -h|--help)
      echo "Usage: $0 [-f|--force-rebuild]"
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg"
      echo "Usage: $0 [-f|--force-rebuild]"
      exit 1
      ;;
  esac
done

if [ "$FORCE_REBUILD" -eq 1 ]; then
  echo "Force rebuild requested. Removing image '$IMAGE'..."
  podman rmi "$IMAGE" >/dev/null 2>&1 || true
fi

if ! podman image exists "$IMAGE"; then
  echo "Building sandbox image..."
  podman build -f "$DOCKERFILE" -t "$IMAGE" .
fi

podman run --rm -it \
  --userns=keep-id \
  -v "$(pwd)":/app:Z \
  -w /app \
  -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
  "$IMAGE" \
  claude --dangerously-skip-permissions

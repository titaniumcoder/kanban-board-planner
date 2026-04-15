#!/usr/bin/env sh
IMAGE="aider-sandbox"
DOCKERFILE="Dockerfile.aider"
FORCE_REBUILD=0
MODEL="${AIDER_MODEL:-ollama_chat/qwen2.5-coder:latest}"
OLLAMA_BASE="${OLLAMA_API_BASE:-http://host.containers.internal:11434}"

for arg in "$@"; do
  case "$arg" in
    -f|--force-rebuild)
      FORCE_REBUILD=1
      ;;
    -h|--help)
      echo "Usage: $0 [-f|--force-rebuild]"
      echo "Env overrides: AIDER_MODEL, OLLAMA_API_BASE"
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
  -e OLLAMA_API_BASE="$OLLAMA_BASE" \
  "$IMAGE" \
  aider --model "$MODEL"

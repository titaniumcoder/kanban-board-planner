# AI Tool Setup

This project includes a local sandbox for running Claude Code in a containerized development environment.

## Files

- [sandbox-claude.sh](../sandbox-claude.sh): helper script to build (if needed) and run the sandbox.
- [Dockerfile.sandbox](../Dockerfile.sandbox): image definition used by the script.

## What the Sandbox Provides

- Elixir 1.18 base image.
- Node.js and npm installed in the image.
- `@anthropic-ai/claude-code` installed globally during image build (no interactive `npx` install prompt on each run).
- Non-root runtime user (`claude`) inside the container.
- Project directory mounted as `/app`, so Claude only sees the current workspace.

## Sandbox Behavior

- The script uses image name `claude-sandbox`.
- If the image does not exist, the script builds it automatically.
- If the image exists, it is reused to avoid rebuilding each run.
- The script runs the container with:
	- `--userns=keep-id` for rootless user mapping.
	- `-v "$(pwd)":/app:Z` to mount only the current directory.
	- `-e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"` to pass the API key.

## Usage

From the repository root:

```sh
./sandbox-claude.sh
```

Force a rebuild of the sandbox image:

```sh
./sandbox-claude.sh -f
```

Show help:

```sh
./sandbox-claude.sh --help
```

## Rebuild Strategy

If you update [Dockerfile.sandbox](../Dockerfile.sandbox), use `-f` once to rebuild and then continue with normal runs.

## Requirements

- Podman installed and working.
- `ANTHROPIC_API_KEY` exported in your shell.

Example:

```sh
export ANTHROPIC_API_KEY="your_key_here"
./sandbox-claude.sh
```


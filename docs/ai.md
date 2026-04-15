# AI Tool Setup

This project supports two AI coding tools: Claude Code (sandboxed via Podman) and Aider (run directly on the host).

## Files

- [sandbox-claude.sh](../sandbox-claude.sh): helper script to build (if needed) and run the Claude sandbox.
- [Dockerfile.sandbox](../Dockerfile.sandbox): image definition used by the Claude script.
- [.aider.conf.yml](../.aider.conf.yml): Aider configuration file, checked into version control.

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

## Aider with Ollama

Aider does not require a sandbox — it proposes diffs and asks for confirmation before applying
any change, and it scopes itself to the directory it is run from.

### Requirements

- Aider installed on your host: `uv tool install --force --python python3.12 --with pip aider-chat@latest`
- Ollama running locally with the model pulled: `ollama pull qwen3-coder-next`
- Alternative use LM Studio

### Usage

From the repository root:

```sh
aider
```

### Configuration

Project-level Aider settings are stored in [.aider.conf.yml](../.aider.conf.yml) and checked
into version control. Personal overrides (like `OLLAMA_API_BASE`) go in `~/.aider.conf.yml`
or as environment variables.

Aider runtime files (history, cache, session state) are excluded via `.gitignore` while
`.aider.conf.yml` is explicitly kept.


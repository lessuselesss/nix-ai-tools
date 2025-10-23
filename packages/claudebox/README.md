# claudebox - responsible YOLO

Open your project in a lightweight sandbox, and avoid unwanted surprises.

The project shadows your $HOME, so no credentials are accessible (except
~/.claude).
The project parent folder is mounted read-only so it's possible to access
other dependencies.

We also patch Claude to monitor all the executed commands in a tmux side-pane.

![Demo](./claudebox-demo.svg)

## Usage

```bash
claudebox [OPTIONS]
```

### Options

- `--split-direction horizontal|vertical` - Set tmux split direction (default: `horizontal`)
- `--no-tmux-config` - Don't load user tmux configuration (use default tmux settings)
- `-h, --help` - Show help message

### Examples

```bash
# Default: run with users tmux config
claudebox

# Vertical split
claudebox --split-direction vertical

# Use default tmux settings (ignore user config)
claudebox --no-tmux-config
```

### Layout

Opens Claude Code with:

- Left pane (horizontal) / Top pane (vertical): Claude interface
- Right pane (horizontal) / Bottom pane (vertical): Live command log

When the layout is not explicitly set, the application adapts to the terminal dimensions.
For very wide terminals, the interface splits vertically: Claude on the left, live command log on the right.
For narrower terminals, the layout adjusts accordingly (stacked panes).

## What it does

- Lightweight sandbox using bubblewrap
- Intercepts all commands via Node.js instrumentation
- Shows commands in real-time in tmux
- Supports custom split direction (horizontal/vertical)
- Loads user tmux configuration by default (can be disabled with `--no-tmux-config`)
- Disables telemetry and auto-updates
- Uses `--dangerously-skip-permissions` (safe in sandbox)

## Note

Not a security boundary - designed for transparency, not isolation.

## Future ideas

- direnv reload integration
- git worktree support

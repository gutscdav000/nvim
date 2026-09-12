# Terminal and Git workflow

Use this stack for local development:

```text
Ghostty → Herdr → Neovim → ToggleTerm/Gitu
                   └────── separate Herdr panes for agents and servers
```

Herdr owns persistent workspaces and long-running processes. ToggleTerm provides
quick shells inside Neovim. Gitu provides a Git dashboard. Neo-tree shows the
project hierarchy, while Oil edits the contents of one directory.

## Installation status

This Mac already has Herdr, Gitu, ToggleTerm, Neo-tree, Oil, Fugitive, and
Harpoon installed. Nothing else is required. On another Mac, run:

```sh
brew install herdr gitu
nvim
```

Then run `:PackerInstall` inside Neovim and restart it. ToggleTerm is pinned to
v2.13.1 in this configuration.

## Start outside tmux

Keep existing tmux sessions alive while learning Herdr. Open a new Ghostty window
or tab and confirm it is outside tmux:

```sh
echo "$TMUX"
```

It should print an empty line. Start Herdr from a project:

```sh
cd /path/to/project
herdr
```

Do not normally run Herdr inside tmux; both would own panes and use `Ctrl-b`.

Herdr commands use `Ctrl-b` as a prefix: press it, release it, then press the
action key.

| Command | Action |
| --- | --- |
| `Ctrl-b ?` | Show all Herdr shortcuts. |
| `Ctrl-b v` / `Ctrl-b -` | Split right / down. |
| `Ctrl-b h/j/k/l` | Move between panes. |
| `Ctrl-b z` | Zoom or restore a pane. |
| `Ctrl-b c` | Create a tab. |
| `Ctrl-b n` / `Ctrl-b p` | Next / previous tab. |
| `Ctrl-b w` | Open the workspace picker. |
| `Ctrl-b [` | Enter copy mode. |
| `Ctrl-b q` | Detach. This differs from tmux's `Ctrl-b d`. |

Run `herdr` again to reattach. Start Neovim in one pane:

```sh
nvim .
```

Create another Herdr pane with `Ctrl-b v` for anything that should survive
quitting Neovim, such as:

```sh
codex
npm run dev
cargo watch
pytest --watch
```

## Use ToggleTerm in Neovim

The Neovim leader key is Space.

| Command | Action |
| --- | --- |
| `Space tt` or `Ctrl-\` | Toggle the project shells. |
| `Space tn` | Create another shell. |
| `Space ts` | Select an existing shell. |
| `:ToggleTermSetName` | Name the current shell for the selector. |
| `Ctrl-\` in a terminal | Hide that terminal. |
| `Ctrl-w h/j/k/l` | Leave terminal input and move between Neovim windows. |
| `Ctrl-w N` | Enter terminal-normal mode for Vim navigation and copying. |
| `i` | Resume terminal input from terminal-normal mode. |

New shells open in a 14-line bottom split at the current file's Git root, or at
Neovim's working directory outside Git. Hiding a terminal preserves its process,
history, environment, and any `cd`. Quitting Neovim ends its ToggleTerm jobs.

Verify persistence:

```sh
pwd
export TERMINAL_DEMO=hello
```

Hide with `Ctrl-\`, reopen with `Space tt`, then run:

```sh
echo "$TERMINAL_DEMO"
```

It should print `hello`.

## Use Gitu and Fugitive

Press `Space gg` from a normal Neovim buffer to open or hide Gitu for the current
repository. Press `h` inside Gitu for context-sensitive help.

| Gitu key | Action |
| --- | --- |
| `j` / `k` | Move down / up. |
| `Tab` | Expand or collapse a section. |
| `b` | Branch menu. |
| `c` | Commit menu. |
| `l` | Log menu. |
| `f` / `F` | Fetch / pull. |
| `P` | Push. |
| `r` | Rebase menu. |
| `z` | Stash menu. |
| `q` or `Esc` | Quit or close the current screen. |
| `Ctrl-\` | Hide Gitu without ending it. |

Gitu supports staging files, hunks, and lines; use `h` because the available
keys depend on the selected section. A commit opens a nested Neovim. Enter the
message and run `:wq` to save it and return to Gitu.

Opening Gitu hides visible bottom terminals, but their processes keep running.
Hide Gitu and use `Space tt` or `Space ts` to restore them. Quitting Gitu with
`q` ends it; the next `Space gg` starts a new process.

Press `Space gs` to use Fugitive instead. Gitu is a dedicated Git dashboard;
Fugitive keeps Git operations in your main Neovim instance. Both remain installed.

## Use Neo-tree and Oil

| Command | Action |
| --- | --- |
| `Space e` | Toggle the Neo-tree project sidebar. |
| `Enter` in Neo-tree | Open a file or expand a directory. |
| `?` in Neo-tree | Show Neo-tree help. |
| `-` | Open the current file's parent directory in Oil. |
| `:w` in Oil | Apply the file operations edited in the Oil buffer. |

Use Neo-tree to understand the project hierarchy. Use Oil to create, rename,
move, or delete files by editing a directory like a normal buffer.

## Move from tmux gradually

1. Leave existing tmux sessions running.
2. Start new local projects in Herdr from a terminal outside tmux.
3. Relaunch old work in Herdr when convenient; live tmux processes cannot migrate.
4. Close old tmux sessions normally after their work is finished.

Herdr preserves processes while its server runs. After a machine restart it can
restore layouts and supported agent sessions, but not the original operating-system
processes. Your `.tmux.conf`, tmux plugins, and scripts that call `tmux` do not
transfer. Keep tmux installed for remote machines where it remains useful.

For local work you only need Ghostty, Herdr, and Neovim. Put quick commands in
ToggleTerm and long-running agents, servers, and watchers in separate Herdr panes.

## Track Herdr configuration

This repository also tracks the Herdr configuration because Herdr is the outer
terminal workspace for the Neovim workflow. The tracked files are under
`herdr/`; the live Herdr config is linked from `~/.config/herdr/config.toml`.

Install or refresh the link with:

```sh
mkdir -p "$HOME/.config/herdr"
ln -sfn "$HOME/.config/nvim/herdr/config.toml" "$HOME/.config/herdr/config.toml"
herdr server reload-config
```

The `Ctrl-b`, `Shift-r` binding opens a popup that renames the agent in the
focused pane. Herdr supplies `HERDR_ACTIVE_PANE_ID` to the tracked helper,
which calls `herdr agent rename` for that pane.

## References

- [ToggleTerm](https://github.com/akinsho/toggleterm.nvim)
- [Gitu](https://github.com/altsem/gitu)
- [Fugitive](https://github.com/tpope/vim-fugitive)
- [Herdr keyboard guide](https://herdr.dev/docs/keyboard/)
- [Herdr session persistence](https://herdr.dev/docs/session-state/)

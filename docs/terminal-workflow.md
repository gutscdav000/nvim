# Terminal and Git workflow

Use Herdr for project workspaces and processes that should survive detaching.
Run Neovim in a Herdr pane. Use ToggleTerm inside Neovim for quick shells and
Gitu, and run long-lived agents or servers in separate Herdr panes.

## Installation

On macOS:

```sh
brew install herdr gitu
```

In Neovim, run `:PackerInstall`, then restart Neovim. ToggleTerm is pinned to
v2.13.1. Neo-tree, Oil, Fugitive, and Harpoon remain available.

## Neovim keys

Leader is Space. These shortcuts are used in normal mode unless stated otherwise.

| Key | Action |
| --- | --- |
| `Ctrl-\` | In the editor: toggle shells. In a ToggleTerm terminal: hide that terminal, including from terminal input mode. |
| `Space tt` | Toggle shells; restores the previous shell layout when available. |
| `Space tn` | Create another shell. |
| `Space ts` | Select a shell using Neovim's built-in numbered picker. |
| `Ctrl-w`, then `h/j/k/l` | Leave terminal input and move to an adjacent Neovim window. |
| `Ctrl-w`, then `N` | Leave terminal input and remain in the terminal buffer to search/copy with normal Vim motions. |
| `i` | Resume typing into a terminal from normal mode. |
| `Space gg` | Open/hide Gitu for the current repository. |
| `Space gs` | Open Fugitive's Git status. |
| `Space e` | Toggle Neo-tree. |
| `-` | Open the parent directory in Oil. |

Shells open in a 14-line bottom split. New shells start at the current file's
Git root, including a linked worktree's root, or at Neovim's working directory
when there is no Git root. When invoked from an existing ToggleTerm buffer,
its original terminal directory is used for root detection. Existing shells keep
their process, history, environment, and any `cd` you perform; switching files
does not silently move them. `:ToggleTermSetName` can name a shell for the picker.

Escape is passed through to terminal applications. Terminal-local `Ctrl-w` is
reserved for Neovim window navigation rather than the shell's delete-word command.
Harpoon's normal-mode `Ctrl-h/t/n/s` bindings are unchanged.

Gitu opens in a large float. Existing shell windows are hidden first because
ToggleTerm does not support simultaneous mixed terminal directions. The shells
keep running; use `Space tt` or `Space ts` to bring them back after hiding Gitu.
Each repository/worktree has its own Gitu instance, excluded from the shell picker.
Press `h` in Gitu for help. `Ctrl-\` hides it without exiting. Quitting Gitu and
reopening it starts a fresh instance.

Gitu's `EDITOR`, `VISUAL`, and `GIT_EDITOR` are set to `nvim` only for its process.
Commit messages and file edits therefore open a nested Neovim inside its terminal;
save and quit that editor to return to Gitu. The outer terminal's `Ctrl-\` and
`Ctrl-w` shortcuts still apply. Use Fugitive if you prefer editing commit messages
in your existing Neovim instance. Unsaved editor changes are not visible to Git.

## Try it

1. Open a file in a Git project. Press `Space tt`, run `pwd`, and check the root.
2. Run `export TERMINAL_DEMO=hello`, hide with `Ctrl-\`, reopen with `Space tt`,
   and run `echo "$TERMINAL_DEMO"`. It should still say `hello`.
3. Return to normal mode with `Ctrl-w N`. Create another shell with `Space tn`.
   Hide it. If focus returns to another shell, press `Ctrl-w N` again, then
   choose between the two shells with `Space ts`.
4. In the editor, press `Space gg`. Browse changes and press `h` for Gitu help.
   Hide it with `Ctrl-\`, then compare `Space gs` for Fugitive.
5. Use `Space e` and `-` to verify your usual explorers, and try Harpoon's keys.

ToggleTerm jobs live inside this Neovim process. Hiding preserves them; quitting
Neovim ends them. Saving an editor session does not preserve live shell jobs.

## Moving from tmux to Herdr

Start in a terminal window outside tmux:

```sh
cd /path/to/project
herdr
```

Run `nvim` in a pane, then create other panes for agents, servers, or a standalone
`gitu`. Keep one Herdr workspace per project. Herdr's defaults already fit this
setup, so no custom Herdr config or Neovim navigation plugin is required.

The prefix is `Ctrl-b`, then release and press the next key:

| Action | Herdr default |
| --- | --- |
| Split right / down | `v` / `-` |
| Move across Herdr panes | `h/j/k/l` |
| New tab | `c` |
| Next / previous tab | `n` / `p` |
| Workspace picker | `w` |
| Zoom pane | `z` |
| Copy mode | `[` |
| Detach | `q` (different from tmux's usual `d`) |
| Help | `?` |

Run `herdr` again to reattach. Existing shell/agent processes remain alive while
the Herdr server stays running. A server or machine restart can restore layouts
and supported agent sessions, but cannot resurrect the original live processes.

Herdr gives you familiar tabs, splits, detaching, and copy mode, plus project and
agent status UI. It is not a drop-in implementation of tmux: your `.tmux.conf`,
tmux plugins, scripts that call `tmux`, and editor/tmux navigation integrations do
not transfer. Remote access also needs a suitable Herdr installation on the remote
host; keeping tmux for machines where it is already available is reasonable.

For new local work, use terminal emulator → Herdr → Neovim → ToggleTerm. You do
not need tmux in that chain. Existing tmux sessions cannot be imported as live
Herdr processes: finish or stop work deliberately and relaunch it in Herdr. Keep
tmux installed during the transition and use either tool for a given workspace.

## References

- [ToggleTerm](https://github.com/akinsho/toggleterm.nvim)
- [Gitu](https://github.com/altsem/gitu)
- [Fugitive](https://github.com/tpope/vim-fugitive)
- [Herdr keyboard guide](https://herdr.dev/docs/keyboard/)
- [Herdr session persistence](https://herdr.dev/docs/session-state/)

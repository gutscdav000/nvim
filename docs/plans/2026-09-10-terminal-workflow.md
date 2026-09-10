# Terminal workflow implementation plan

**Goal:** Add reusable project shells and a Gitu popup to the existing Neovim
configuration, with Herdr managing the surrounding persistent workspace.

**Architecture:** Keep Neo-tree, Oil, Fugitive, and Harpoon. Use ToggleTerm for
bottom shells and a separate Gitu float. Resolve new terminals from the current
file's Git root (including worktrees), falling back to Neovim's cwd. Existing
terminals retain their directories. Keep Herdr's default prefix bindings.

**Tech stack:** Neovim Lua, Packer, ToggleTerm v2.13.1, Gitu, Herdr.

## Implementation and validation

1. Install Gitu through Homebrew and ToggleTerm through Packer without updating
   unrelated plugins. Confirm the missing terminal integration before adding it.
2. Add `after/plugin/toggleterm.lua`: toggle/new/select shells, terminal navigation,
   and a per-repository Gitu float. Hide split terminals before opening the float.
   Leave Escape and Harpoon shortcuts intact.
3. Update `CLAUDE.md` and add a user guide with installation, keymaps, a manual
   smoke test, and Herdr/tmux ownership and persistence differences.
4. Exercise actual Neovim terminal jobs: hide/reopen preserves process state,
   multiple terminals and picker, paths with spaces and worktrees, Gitu render
   and exit/reopen, Neo-tree/Oil/Fugitive coexistence, and existing keymaps.
5. Exercise Herdr in an isolated named session, including detach/reattach, without
   disturbing any existing session. Review the diff, then create a branch, commit,
   push, and open a pull request as requested.

## Validation results

Validated on 2026-09-10 with Neovim 0.12.1, ToggleTerm 2.13.1, Gitu 0.43.0,
and Herdr 0.9.0. Real terminal UIs were driven through PTYs and inspected through
Neovim RPC; this was not a desktop mouse/screenshot test.

- Shell environment and job identity survive hide/reopen; creation and the
  numbered terminal picker work. Window navigation and terminal normal mode work.
- New shells resolve repositories and linked worktrees with spaces in their paths;
  non-Git projects fall back to cwd.
- Gitu renders status/help, hides split shells, preserves its job when hidden,
  restarts after exit, and uses independent instances for separate worktrees.
- Gitu launched nested Neovim for a commit in a disposable fixture repository,
  saved the commit, and returned to the Git UI.
- Neo-tree, Oil, Fugitive, and existing Harpoon mappings remain functional.
- A separate Herdr test session split panes and retained shell state through
  detach/reattach. Neovim, ToggleTerm, and Gitu ran together in a Herdr pane.
- Fresh Neovim startup and `git diff --check` passed. Independent review caught
  an unavailable API in the pinned ToggleTerm release; the corrected terminal
  constructor passed the live tests and follow-up review.

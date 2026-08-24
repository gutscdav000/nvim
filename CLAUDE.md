# Neovim config

Leader key is `<Space>` (`vim.g.mapleader = " "`).

## Rules

- **Whenever a keymap/remap is created, changed, or removed, update the Keymaps table below in the same change.** It must stay in sync with the actual mappings defined in `lua/dgutsch/remap.lua` and `after/plugin/*.lua`.

## Keymaps

| Keymap        | Mode | Action                                          | File                          |
| ------------- | ---- | ----------------------------------------------- | ----------------------------- |
| `<leader>fj`  | n    | Format the current buffer as JSON via `jq`      | `lua/dgutsch/remap.lua`       |
| `<leader>pv`  | n    | Oil: open parent directory                      | `after/plugin/oil.lua`        |
| `-`           | n    | Oil: open parent directory                      | `after/plugin/oil.lua`        |
| `<leader>pd`  | n    | Oil: open parent directory in a floating window | `after/plugin/oil.lua`        |
| `<leader>pf`  | n    | Telescope: find files                           | `after/plugin/telescope.lua`  |
| `<C-p>`       | n    | Telescope: find git-tracked files               | `after/plugin/telescope.lua`  |
| `<leader>ps`  | n    | Telescope: grep for a prompted string           | `after/plugin/telescope.lua`  |
| `<leader>a`   | n    | Harpoon: add current file to marks              | `after/plugin/harpoon.lua`    |
| `<C-e>`       | n    | Harpoon: toggle quick menu                      | `after/plugin/harpoon.lua`    |
| `<C-h>`       | n    | Harpoon: jump to marked file 1                  | `after/plugin/harpoon.lua`    |
| `<C-t>`       | n    | Harpoon: jump to marked file 2                  | `after/plugin/harpoon.lua`    |
| `<C-n>`       | n    | Harpoon: jump to marked file 3                  | `after/plugin/harpoon.lua`    |
| `<C-s>`       | n    | Harpoon: jump to marked file 4                  | `after/plugin/harpoon.lua`    |
| `<leader>e`   | n    | Neo-tree: toggle the sidebar file tree          | `after/plugin/neotree.lua`    |
| `<leader>gs`  | n    | Fugitive: open Git status                       | `after/plugin/fugative.lua`   |
| `<leader>u`   | n    | Toggle Undotree                                 | `after/plugin/undotree.lua`   |
| `<C-space>`   | i    | blink.cmp: show / toggle documentation          | `after/plugin/blink-cmp.lua`  |
| `<C-e>`       | i    | blink.cmp: hide the completion menu             | `after/plugin/blink-cmp.lua`  |
| `<C-p>`       | i    | blink.cmp: select previous completion item      | `after/plugin/blink-cmp.lua`  |
| `<C-n>`       | i    | blink.cmp: select next completion item          | `after/plugin/blink-cmp.lua`  |
| `<Tab>`       | i    | blink.cmp: `super-tab` preset cycles completion | `after/plugin/blink-cmp.lua`  |

Note: `<C-e>`, `<C-n>`, and `<C-p>` are Harpoon/Telescope in normal mode and
blink.cmp in insert mode. Different modes, so they do not conflict.

## Two explorers, on purpose

- **oil** (`-`, `<leader>pv`) edits a single directory as a buffer. It cannot
  display a tree — that is a deliberate non-feature upstream.
- **neo-tree** (`<leader>e`) is the persistent sidebar with nested hierarchy.

`neotree.lua` sets `hijack_netrw_behavior = "disabled"` so oil keeps ownership of
directory buffers.

### Oil buffer-local overrides

Oil binds `<C-h>`, `<C-t>`, `<C-s>`, and `<C-p>` by default, which would shadow
Harpoon nav and Telescope git-files inside an oil buffer. Those four are disabled
and rebound in `after/plugin/oil.lua`:

| Keymap  | Action                        | Replaces oil default |
| ------- | ----------------------------- | -------------------- |
| `<C-x>` | Oil: open selection in hsplit | `<C-h>`              |
| `<C-v>` | Oil: open selection in vsplit | `<C-s>`              |
| `gt`    | Oil: open selection in a tab  | `<C-t>`              |
| `gp`    | Oil: preview selection        | `<C-p>`              |

All other oil defaults are unchanged (`<CR>` select, `-` parent, `_` cwd,
`g.` toggle hidden, `g?` help). `g?` lists the full set.

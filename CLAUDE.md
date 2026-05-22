# Neovim config

Leader key is `<Space>` (`vim.g.mapleader = " "`).

## Rules

- **Whenever a keymap/remap is created, changed, or removed, update the Keymaps table below in the same change.** It must stay in sync with the actual mappings defined in `lua/dgutsch/remap.lua` and `after/plugin/*.lua`.

## Keymaps

| Keymap        | Mode | Action                                          | File                          |
| ------------- | ---- | ----------------------------------------------- | ----------------------------- |
| `<leader>pv`  | n    | Open netrw file explorer (`:Ex`)                | `lua/dgutsch/remap.lua`       |
| `<leader>fj`  | n    | Format the current buffer as JSON via `jq`      | `lua/dgutsch/remap.lua`       |
| `<leader>pf`  | n    | Telescope: find files                           | `after/plugin/telescope.lua`  |
| `<C-p>`       | n    | Telescope: find git-tracked files               | `after/plugin/telescope.lua`  |
| `<leader>ps`  | n    | Telescope: grep for a prompted string           | `after/plugin/telescope.lua`  |
| `<leader>a`   | n    | Harpoon: add current file to marks              | `after/plugin/harpoon.lua`    |
| `<C-e>`       | n    | Harpoon: toggle quick menu                      | `after/plugin/harpoon.lua`    |
| `<C-h>`       | n    | Harpoon: jump to marked file 1                  | `after/plugin/harpoon.lua`    |
| `<C-t>`       | n    | Harpoon: jump to marked file 2                  | `after/plugin/harpoon.lua`    |
| `<C-n>`       | n    | Harpoon: jump to marked file 3                  | `after/plugin/harpoon.lua`    |
| `<C-s>`       | n    | Harpoon: jump to marked file 4                  | `after/plugin/harpoon.lua`    |
| `<leader>gs`  | n    | Fugitive: open Git status                       | `after/plugin/fugative.lua`   |
| `<leader>u`   | n    | Toggle Undotree                                 | `after/plugin/undotree.lua`   |

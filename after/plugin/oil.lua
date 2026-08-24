local ok, oil = pcall(require, "oil")
if not ok then return end

oil.setup({
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        -- Oil binds these by default, but they are harpoon nav (<C-h>/<C-t>/<C-s>)
        -- and telescope git_files (<C-p>). Keep those working inside oil buffers.
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-s>"] = false,
        ["<C-p>"] = false,
        ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["gp"] = "actions.preview",
        ["gt"] = { "actions.select", opts = { tab = true } },
    },
})

-- Oil disables netrw, so <leader>pv replaces the old :Ex mapping.
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory in oil" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory in oil" })
vim.keymap.set("n", "<leader>pd", "<CMD>Oil --float<CR>", { desc = "Open parent directory in a floating oil window" })

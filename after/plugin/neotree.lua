local ok, neotree = pcall(require, "neo-tree")
if not ok then return end

neotree.setup({
    filesystem = {
        -- Oil owns directory buffers (- and <leader>pv). Leave netrw hijacking
        -- to oil so the two explorers do not fight over the same buffers.
        hijack_netrw_behavior = "disabled",
        -- Keep the sidebar in sync with the buffer you are editing.
        follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
    window = {
        width = 32,
        mappings = {
            -- Neo-tree binds <space> to toggle_node by default, but <space> is
            -- the leader key. <CR> already opens/toggles, so give leader back.
            ["<space>"] = "noop",
        },
    },
})

vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>", { desc = "Toggle neo-tree sidebar" })

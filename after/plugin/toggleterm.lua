local ok, toggleterm = pcall(require, "toggleterm")
if not ok then return end

local terminals = require("toggleterm.terminal")

local function project_dir()
    local _, terminal = terminals.identify()
    local start = terminal and terminal.dir or 0
    return vim.fs.root(start, ".git") or vim.fn.getcwd()
end

toggleterm.setup({
    size = 14,
    direction = "horizontal",
    shade_terminals = false,
    start_in_insert = true,
    persist_mode = false,
    autochdir = false,
    on_open = function(terminal)
        -- Keep Escape and Ctrl-h/t/n/s available to the program in the terminal.
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], {
            buffer = terminal.bufnr,
            desc = "Leave terminal input and use a window command",
        })
        vim.keymap.set({ "n", "t" }, [[<C-\>]], function()
            if terminal.hidden then
                terminal:close()
            else
                toggleterm.toggle(terminal.id)
            end
        end, { buffer = terminal.bufnr, desc = "Hide this terminal" })
    end,
})

vim.keymap.set("n", [[<C-\>]], function()
    toggleterm.toggle(nil, nil, project_dir())
end, { desc = "Toggle project terminals" })
vim.keymap.set("n", "<leader>tt", function()
    toggleterm.toggle(nil, nil, project_dir())
end, { desc = "Toggle project terminals" })
vim.keymap.set("n", "<leader>tn", function()
    local dir = project_dir()
    local _, current = terminals.identify()
    if current and current:is_float() then current:close() end
    terminals.Terminal:new({ dir = dir, direction = "horizontal" }):open()
end, { desc = "New project terminal" })
vim.keymap.set("n", "<leader>ts", "<CMD>TermSelect<CR>", { desc = "Select terminal" })

-- Each repository/worktree gets its own Gitu process, separate from shell selection.
local gitu_by_dir = {}
vim.keymap.set("n", "<leader>gg", function()
    if vim.fn.executable("gitu") == 0 then
        vim.notify("Gitu is not installed. Run: brew install gitu", vim.log.levels.WARN)
        return
    end

    local dir = project_dir()
    local gitu = gitu_by_dir[dir]
    if gitu and gitu:is_open() then
        gitu:close()
        return
    end

    -- ToggleTerm does not support mixed terminal directions at the same time.
    for _, terminal in ipairs(terminals.get_all(true)) do
        if terminal:is_open() then terminal:close() end
    end

    if not gitu then
        gitu = terminals.Terminal:new({
            cmd = "gitu",
            dir = dir,
            direction = "float",
            hidden = true,
            display_name = "Gitu: " .. vim.fs.basename(dir),
            float_opts = {
                border = "rounded",
                width = function() return math.max(1, math.floor(vim.o.columns * 0.9)) end,
                height = function() return math.max(1, math.floor(vim.o.lines * 0.85)) end,
            },
            -- Gitu's commit/file editor opens a nested Neovim in this terminal.
            env = { EDITOR = "nvim", VISUAL = "nvim", GIT_EDITOR = "nvim" },
            on_exit = function()
                gitu_by_dir[dir] = nil
            end,
        })
        gitu_by_dir[dir] = gitu
    end
    gitu:open()
end, { desc = "Toggle Gitu for this project" })

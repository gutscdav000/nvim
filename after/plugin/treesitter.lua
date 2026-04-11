local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

configs.setup({
    ensure_installed = {
        "help",
        "typescript",
        "javascript",
        "rust",
        "markdown",
        "html",
        "scala",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
	additional_vim_regex_highlighting = false,
    },
})

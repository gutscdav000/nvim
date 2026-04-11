local ok, blink = pcall(require, 'blink.cmp')
if not ok then return end

blink.setup({
    keymap = {
        preset = 'super-tab',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
    },
    completion = {
        list = {
            selection = { preselect = true, auto_insert = true },
        },
        documentation = {
            auto_show = true,
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})

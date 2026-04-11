-- TypeScript / JavaScript
vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
})

-- Python
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
})

-- Rust
vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml' },
})

-- Scala
vim.lsp.config('metals', {
    cmd = { 'metals' },
    filetypes = { 'scala', 'sbt', 'java' },
    root_markers = { 'build.sbt', 'build.sc', 'build.gradle', 'pom.xml', '.git' },
})

vim.lsp.enable({ 'ts_ls', 'pyright', 'rust_analyzer', 'metals' })

# Neovim LSP Setup Guide

For shells, Gitu, and moving from tmux to Herdr, see the
[terminal workflow guide](docs/terminal-workflow.md).

This guide explains how Neovim's built-in LSP client works and how to set up
language servers for TypeScript, JavaScript, Python, Rust, and Scala.

## How LSP Works in Neovim (0.11+)

LSP (Language Server Protocol) is a standard that lets editors communicate with
**language servers** — separate programs that understand a specific language and
provide features like autocompletion, go-to-definition, diagnostics, and
refactoring.

The architecture is simple:

```
Neovim (client)  <--stdio-->  Language Server (separate process)
```

Neovim has a **built-in LSP client** (no plugins needed). You just need to:

1. **Install** the language server binary on your system
2. **Configure** it with `vim.lsp.config()` — tell Neovim how to start it
3. **Enable** it with `vim.lsp.enable()` — tell Neovim to use it

### Key Concepts

- **cmd**: The shell command to start the language server. Most servers
  communicate over stdio.
- **filetypes**: Which file types trigger this server (e.g., `"rust"` files
  start `rust-analyzer`).
- **root_markers**: Files that identify the project root (e.g., `Cargo.toml`
  for Rust). The LSP client uses this to set the working directory so the
  server understands your project structure.

## Step 1: Install Language Servers

Each language server is an independent program. You install them the same way
you install any CLI tool.

### TypeScript / JavaScript: `typescript-language-server`

```bash
npm install -g typescript-language-server typescript
```

This installs two things:
- `typescript` — the compiler that the server uses internally
- `typescript-language-server` — the LSP server that wraps it

Verify: `typescript-language-server --version`

### Python: `pyright`

```bash
# With npm (recommended)
npm install -g pyright

# Or with pip
pip install pyright

# Or with Nix
nix profile install nixpkgs#pyright
```

Verify: `pyright --version`

### Rust: `rust-analyzer`

```bash
# If you installed Rust via rustup:
rustup component add rust-analyzer

# Or with Homebrew:
brew install rust-analyzer

# Or with Nix:
nix profile install nixpkgs#rust-analyzer
```

Verify: `rust-analyzer --version`

### Scala: `metals`

```bash
# With Homebrew:
brew install metals

# Or with Coursier (Scala's package manager):
cs install metals

# Or with Nix:
nix profile install nixpkgs#metals
```

Verify: `metals --version`

## Step 2: Configure the Servers in Neovim

Create the file `after/plugin/lsp.lua` in your Neovim config directory. This
file tells Neovim how to start each language server.

See `after/plugin/lsp.lua` in this repository for the full configuration.

Each `vim.lsp.config()` call registers a server. The arguments are:

```lua
vim.lsp.config('server_name', {
    cmd = { 'command-to-run', '--flags' },   -- how to start the server
    filetypes = { 'filetype1', 'filetype2' }, -- when to start it
    root_markers = { 'marker-file' },         -- how to find the project root
})
```

Then `vim.lsp.enable()` activates them all.

## Step 3: Using LSP in Neovim

Once configured, LSP features are available automatically when you open a file
that matches a configured filetype. Neovim provides default keybindings:

| Keybinding     | Action                          |
|----------------|---------------------------------|
| `grn`          | Rename symbol                   |
| `gra`          | Code action                     |
| `grr`          | Show references                 |
| `gri`          | Show implementations            |
| `gO`           | Document symbols                |
| `K`            | Hover documentation             |
| `CTRL-]`       | Go to definition                |

Diagnostics (errors/warnings) appear inline automatically.

## Step 4: Verify It Works

1. Open a project file (e.g., a `.rs` file inside a Cargo project)
2. Run `:checkhealth lsp` to verify the server attached
3. Try `K` on a symbol to see hover docs
4. Try `CTRL-]` on a symbol to jump to its definition

## Troubleshooting

- **Server not starting?** Make sure the binary is on your `$PATH`. Run the
  `cmd` manually in your terminal to verify.
- **No diagnostics?** Check `:LspLog` for errors. The server may not have
  found the project root — ensure your `root_markers` file exists.
- **`:checkhealth lsp`** — always start here. It shows which servers are
  attached and any errors.

## Adding a New Language Server in the Future

1. Find the server for your language (see https://langserver.org or
   https://microsoft.github.io/language-server-protocol/implementors/servers/)
2. Install the binary
3. Add a `vim.lsp.config()` block with `cmd`, `filetypes`, and `root_markers`
4. Add the name to `vim.lsp.enable()`
5. Open a file and run `:checkhealth lsp`

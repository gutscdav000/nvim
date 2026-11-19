


## use text objects with i (inner) or a (around)
- ci( - change inside parenthesis
- ci" - change inside quotes
- ci{ - change inside braces
- di[ - dleete inside brackets
- ya) - yank around parenthesis (includes parens)

## text wrapping (nvim-surround)
- ysiw) - surround word with parenthesis
- ysiw" - surround word with quotes
- cs"' - change surround " to '
- ds( - delete surrounded parentehsis
- ya) - yank around parenthesis (includes parens)

## lsp built in commands

gd  - go to definition
gD  - go to delcaration
grr - show references
gri - go to implementation
g0 - document symbols (outline)
K - hover documentation
<C-s> insert - signature help

### other useful lsp actions:
grn - rename symbol
gra - code actions
`:lua vim.diagnostic.open_float()` - show diagnostic popoup
]d / [d - Next/Previous diagnostic


## Navigation (jumplist)

<C-o> - jump backwards (previous location)
<C-i> - jump forward
:jumps - show full jump history

## terminal insert mode (<C-\><C-p>), then use standard window resize commands
- <C-w>+ / <C-w)- = increase/decrease height
- <C-w>> / <C-w>< - increase/decrease width
- <C-w>= - equalize all splits
- :resize 20 or :res +5 - set or adjust height directly

The config already maps <C-w> in terminal mode to <C-\><C-n><C-w>, so you can skip the escape step — just type <C-w>+ directly from the terminal and it will work.

## fugative commands

## PR diff
- <leader>gds - PR diff --stat overview
- <leader>gdd - PR diff as one unified buffer
- <leader>gdt - PR difftool: side-by-side, file by file via quickfix
- <leader>gl - PR commit log (base..branch)


# nvim-config

My Neovim configuration: C/C++ and embedded firmware first (clangd, clang-format,
ARM assembly), plus Go, Lua, CMake, Arduino and Markdown/vimwiki notes.
Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), language servers by
[Mason](https://github.com/williamboman/mason.nvim). Leader is `Space`.

## Requirements

- Neovim **0.12+** (uses `vim.lsp.config`, `vim.lsp.enable`, `win_splitmove`)
- `git`, a C compiler and `make` (telescope-fzf-native, tree-sitter parsers)
- [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter) **0.26+** from your package
  manager (nvim-treesitter `main` branch builds parsers with it)
- `ripgrep` for live grep
- A Nerd Font for icons

## Install

```sh
mv ~/.config/nvim ~/.config/nvim.bak        # keep an existing config
git clone git@github.com:joseccarmo/nvim-config.git ~/.config/nvim
nvim                                        # lazy.nvim installs the plugins
```

Then `:TSUpdate` for the tree-sitter parsers and `:Mason` to check the language servers.
`lazy-lock.json` pins plugin versions; `:Lazy update` moves them forward.

## Layout

```
init.lua                 autocmds: LSP keymaps, yank highlight, trailing-whitespace trim
lua/duck/set.lua         options (relative numbers, 4-space indent, nowrap, no swapfile)
lua/duck/remap.lua       keymaps
lua/config/lazy.lua      lazy.nvim bootstrap
lua/plugins/*.lua        one file per plugin
after/ftplugin/          markdown/vimwiki: soft wrap at word boundaries, j/k by screen line
```

## Plugins

| Area | Plugins |
|---|---|
| LSP and completion | nvim-lspconfig, mason + mason-lspconfig, nvim-cmp (+ buffer, path, cmdline, LuaSnip), fidget |
| Language servers | clangd, lua_ls, gopls, asm_lsp, neocmake, arduino_language_server, harper_ls (grammar), intelephense |
| Formatting | conform.nvim (clang-format for C/C++, LSP fallback) |
| Syntax | nvim-treesitter (`main`): c, cpp, asm, make, lua, vim, vimdoc, bash, json, markdown |
| Navigation | telescope (+ fzf-native), harpoon 2, undotree, vim-fugitive |
| Notes | vimwiki (markdown syntax), render-markdown, calendar-vim |
| Look | fluoromachine, mini.icons, nvim-web-devicons, nvim-autopairs |
| Personal | `study.lua`: loads only where `~/study/nvim` exists; skipped elsewhere |

## Keymaps

**Windows**

| Keys | Action |
|---|---|
| `Alt+h/j/k/l` | focus the window in that direction |
| `Alt+Shift+h/j/k/l` | move the window that way, like Hyprland: joins the neighbouring column or row, swaps within its own, becomes a full column/row at the edge |
| `Alt+q` | close the window |

**Files and search**

| Keys | Action |
|---|---|
| `<leader>pv` | file explorer (netrw) |
| `<leader>ff` / `<C-p>` | find files / git files |
| `<leader>fg` / `<leader>fb` / `<leader>fh` | live grep / buffers / help tags |
| `<leader>a`, `<C-e>` | harpoon: add file, menu |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | harpoon: files 1-4 |
| `<C-S-p>` / `<C-S-n>` | harpoon: previous / next |

**LSP and diagnostics** (buffer-local once a server attaches)

| Keys | Action |
|---|---|
| `gd` / `K` | definition / hover |
| `<leader>vrr` / `<leader>vrn` | references / rename |
| `<leader>vca` / `<leader>vws` | code action / workspace symbol |
| `<leader>vd`, `<leader>e` | diagnostic float |
| `[d` / `]d` | next / previous diagnostic |
| `<leader>q` | diagnostics into the quickfix list |
| `<C-h>` (insert) | signature help |
| `<leader>fm` | format file or selection (conform) |

**Editing**

| Keys | Action |
|---|---|
| `J` / `K` (visual) | move the selection down / up |
| `<leader>p` (visual) | paste over without losing the register |
| `<leader>y` / `<leader>Y` | yank to the system clipboard |
| `<leader>d` | delete without yanking |
| `<leader>s` | substitute the word under the cursor in the file |
| `<C-d>` / `<C-u>`, `n` / `N` | scroll / search, keeping the cursor centred |
| `]q` / `[q` | next / previous quickfix entry (Neovim defaults) |
| `<leader>gs` / `<leader>u` | git status (fugitive) / undotree |
| `<leader>x` | `chmod +x` the current file |
| `<leader><leader>` | source the current file |
| `F3` | calendar (vimwiki diary) |

## Notes

- **nvim-treesitter is on `main`:** highlighting is started per filetype in
  `lua/plugins/treesitter.lua`. vimwiki keeps its own syntax; render-markdown still uses
  the markdown parser.
- **asm_lsp** shows x86 documentation by default. Its "arm" data set is AArch64, so for
  Cortex-M (Thumb) code it is not a reliable reference.
- Paths that are personal (`~/vimwiki`, `~/.arduino15`, `~/study`) are optional: the config
  starts without them.

# Cheatsheet

Every binding in this repo that is not a vim or tmux default. Leader is `Space`.

Every row names the plugin it comes from, so a search finds all of a plugin's
keys at once: `harpoon`, `telescope`, `oil`, or a key like `<leader>f`. In
nvim, `/telescope` in this file works the same way.

Modes: `n` normal, `i` insert, `v` visual, `c` command line.

- [Neovim](#neovim)
  - [Core](#core) · [Diagnostics](#diagnostics) · [LSP](#lsp) · [Formatting](#formatting)
  - [Telescope](#telescope) · [Harpoon](#harpoon) · [Oil](#oil) · [Undotree](#undotree)
  - [Completion](#completion) · [Copilot](#copilot) · [Command line](#command-line)
  - [Git](#git) · [Compile mode](#compile-mode) · [Markdown preview](#markdown-preview)
  - [Start screen](#start-screen) · [Plugins without keys](#plugins-without-keys)
- [tmux](#tmux) · [Ghostty](#ghostty) · [zsh](#zsh)

## Neovim

### Core

Plain nvim, from `nvim/lua/mappings.lua`.

| Key           | Mode    | Plugin | Does                                 |
| ------------- | ------- | ------ | ------------------------------------ |
| `;`           | n       | core   | Enter command mode, no shift needed  |
| `jk`          | i       | core   | Escape                               |
| `<C-h/j/k/l>` | n       | core   | Move to window left, down, up, right |
| `<C-\>`       | n       | core   | Jump to the compilation window       |
| arrow keys    | n, i, v | core   | Disabled                             |

On macOS `<C-k>` is also the tmux prefix, so tmux eats it first. Press `<C-k>`
twice to reach the nvim window-up mapping.

### Diagnostics

Built in, `vim.diagnostic`.

| Key          | Mode | Plugin     | Does                                   |
| ------------ | ---- | ---------- | -------------------------------------- |
| `[d` / `]d`  | n    | diagnostic | Previous, next diagnostic with a float |
| `<leader>df` | n    | diagnostic | Show the diagnostic under the cursor   |
| `<leader>dl` | n    | diagnostic | Send diagnostics to the location list  |
| `<leader>dq` | n    | diagnostic | Send diagnostics to the quickfix list  |
| `<leader>dt` | n    | telescope  | Browse diagnostics in Telescope        |

### LSP

nvim-lspconfig, and rustaceanvim for Rust with the same keys. Buffer-local,
active once a server attaches.

| Key          | Mode | Plugin  | Does                              |
| ------------ | ---- | ------- | --------------------------------- |
| `gd`         | n    | lsp     | Definition                        |
| `gD`         | n    | lsp     | Declaration                       |
| `gi`         | n    | lsp     | Implementation                    |
| `gr`         | n    | lsp     | References                        |
| `K`          | n    | lsp     | Hover docs                        |
| `<C-k>`      | i    | lsp     | Signature help                    |
| `<leader>ca` | n, v | lsp     | Code action                       |
| `<leader>rn` | n    | lsp     | Rename symbol                     |
| `<leader>lf` | n    | conform | Format with conform, LSP fallback |

Language servers are installed by mason (`:Mason`).

### Formatting

conform.nvim formats on save, no keys besides `<leader>lf` above.

### Telescope

telescope.nvim, all under `<leader>f`.

| Key          | Mode | Plugin    | Does                                          |
| ------------ | ---- | --------- | --------------------------------------------- |
| `<leader>ff` | n    | telescope | Find files in cwd                             |
| `<leader>fF` | n    | telescope | Pick a directory first, then find files in it |
| `<leader>fA` | n    | telescope | Find files anywhere, outside the project      |
| `<leader>fw` | n    | telescope | Live grep                                     |
| `<leader>fg` | n    | telescope | Live grep, same as `<leader>fw`               |
| `<leader>fb` | n    | telescope | Buffers                                       |
| `<leader>fh` | n    | telescope | Help tags                                     |
| `<leader>fo` | n    | telescope | Recent files                                  |
| `<leader>fy` | n    | neoclip   | Yank history                                  |
| `<leader>dt` | n    | telescope | Diagnostics                                   |

### Harpoon

harpoon, branch `harpoon2`.

| Key                        | Mode | Plugin  | Does                         |
| -------------------------- | ---- | ------- | ---------------------------- |
| `<leader>a`                | n    | harpoon | Add current file to the list |
| `<C-e>`                    | n    | harpoon | Toggle the quick menu        |
| `<leader>1` .. `<leader>4` | n    | harpoon | Jump to slot 1 to 4          |
| `<leader>hc`               | n    | harpoon | Clear the whole list         |

In the quick menu it is a normal buffer: `dd` removes an entry, `ddp` reorders,
then `:w` to save. `q` and `<Esc>` close without saving, so a deletion you did
not write is discarded.

### Oil

oil.nvim, the file explorer. `<leader>e` opens it in the current window. The
preview opens on its own and follows the cursor.

| Key         | Mode | Plugin | Does                                            |
| ----------- | ---- | ------ | ----------------------------------------------- |
| `<leader>e` | n    | oil    | Open oil                                        |
| `<CR>`      | n    | oil    | Open the entry                                  |
| `-`         | n    | oil    | Go to parent directory                          |
| `_`         | n    | oil    | Open cwd                                        |
| `` ` ``     | n    | oil    | `cd` to this directory                          |
| `<C-s>`     | n    | oil    | Open in a vertical split                        |
| `<C-h>`     | n    | oil    | Open in a horizontal split                      |
| `<C-t>`     | n    | oil    | Open in a tab                                   |
| `<C-p>`     | n    | oil    | Toggle the preview                              |
| `<C-l>`     | n    | oil    | Refresh                                         |
| `<C-c>`     | n    | oil    | Close oil                                       |
| `gs`        | n    | oil    | Change sort                                     |
| `g.`        | n    | oil    | Toggle hidden files, already on by default here |
| `gx`        | n    | oil    | Open with the system handler                    |
| `g?`        | n    | oil    | Show all oil keymaps                            |

Oil edits the filesystem through the buffer: rename a line, `dd` to delete, `p`
to copy, then `:w` to apply. It asks for confirmation first. oil-git-status
shows each file's git status in the sign column.

### Undotree

| Key         | Mode | Plugin   | Does                 |
| ----------- | ---- | -------- | -------------------- |
| `<leader>u` | n    | undotree | Toggle the undo tree |

### Completion

nvim-cmp, with LuaSnip for snippets.

| Key         | Mode | Plugin | Does                                        |
| ----------- | ---- | ------ | ------------------------------------------- |
| `<Tab>`     | i    | cmp    | Next item, or jump to the next snippet stop |
| `<S-Tab>`   | i    | cmp    | Previous item, or the previous snippet stop |
| `<CR>`      | i    | cmp    | Confirm the selected item                   |
| `<C-Space>` | i    | cmp    | Trigger completion                          |
| `<C-e>`     | i    | cmp    | Abort                                       |

The command line completes too: `:` history, and zsh history on `:!` lines.

### Copilot

copilot.lua, inline suggestions only, no panel.

| Key     | Mode | Plugin  | Does                  |
| ------- | ---- | ------- | --------------------- |
| `<C-l>` | i    | copilot | Accept the suggestion |
| `<C-g>` | i    | copilot | Next suggestion       |
| `<C-x>` | i    | copilot | Dismiss               |

The lualine section shows yellow when the Copilot client is attached and grey
when it is not.

### Command line

wilder.nvim renders the `:`, `/` and `?` wildmenu with fuzzy matching. No keys
of its own: type, and `<Tab>` moves through the matches.

### Git

| Key          | Mode | Plugin   | Does                              |
| ------------ | ---- | -------- | --------------------------------- |
| `<leader>gg` | n    | lazygit  | LazyGit                           |
| `<leader>gs` | n    | fugitive | Status                            |
| `<leader>gc` | n    | fugitive | Commit                            |
| `<leader>gp` | n    | fugitive | Push                              |
| `<leader>gl` | n    | fugitive | Pull                              |
| `<leader>gd` | n    | fugitive | Diff against the index in a split |

gitsigns draws the signs in the gutter, no keys. `:Octo` (octo.nvim) handles
GitHub issues and pull requests.

### Compile mode

compile-mode.nvim.

| Key          | Mode | Plugin       | Does                                         |
| ------------ | ---- | ------------ | -------------------------------------------- |
| `<leader>cc` | n    | compile-mode | Compile, prompts for the command             |
| `<leader>cr` | n    | compile-mode | Recompile with the last command              |
| `<leader>ch` | n    | compile-mode | Command history                              |
| `<C-\>`      | n    | compile-mode | Jump to the compilation window from anywhere |

Inside the compilation buffer:

| Key     | Mode | Plugin       | Does                                                       |
| ------- | ---- | ------------ | ---------------------------------------------------------- |
| `<CR>`  | n    | compile-mode | Jump to the error under the cursor, reusing an open window |
| `<C-q>` | n    | compile-mode | Send errors to the quickfix list and open it               |
| `<C-\>` | n    | compile-mode | Jump back to the code                                      |
| `i`     | n    | compile-mode | Send a line to the running program's stdin                 |
| `<C-d>` | n    | compile-mode | Send EOF to the running program                            |

### Markdown preview

markdown-preview.nvim, in Markdown buffers only.

| Key          | Mode | Plugin           | Does                                   |
| ------------ | ---- | ---------------- | -------------------------------------- |
| `<leader>mb` | n    | markdown-preview | Toggle the live preview in the browser |

The page updates as you type and follows the cursor, on port `8090`. Locally it
opens the default browser. Over ssh it prints the URL instead: open it in the
browser on the machine you are typing on.

### Start screen

snacks.nvim dashboard, shown when nvim starts without a file.

| Key | Mode | Plugin | Does                     |
| --- | ---- | ------ | ------------------------ |
| `f` | n    | snacks | Find file                |
| `r` | n    | snacks | Recent files             |
| `g` | n    | snacks | Grep                     |
| `e` | n    | snacks | Explorer (oil)           |
| `c` | n    | snacks | Open the plugin config   |
| `l` | n    | snacks | Lazy, the plugin manager |
| `q` | n    | snacks | Quit                     |

### Plugins without keys

| Plugin          | Does                                                                          |
| --------------- | ----------------------------------------------------------------------------- |
| nvim-treesitter | Syntax highlighting. Parsers install on first start, `:TSUpdate` updates them |
| gruvbox.nvim    | Colorscheme                                                                   |
| lualine.nvim    | Status line                                                                   |
| mason.nvim      | Installs language servers and formatters, `:Mason`                            |
| gitsigns.nvim   | Git signs in the gutter                                                       |
| wilder.nvim     | Fuzzy wildmenu on the command line                                            |
| octo.nvim       | GitHub issues and pull requests, `:Octo`                                      |
| lazy.nvim       | Plugin manager, `:Lazy`                                                       |

## tmux

Prefix is `C-k` on macOS and `C-s` on Linux, so a nested session is always
reachable. Press the prefix twice to send it through to the inner program.

### Windows and panes

| Key              | Plugin | Does                                |
| ---------------- | ------ | ----------------------------------- |
| `M-h` / `M-l`    | tmux   | Previous, next window, no prefix    |
| prefix `H` / `L` | tmux   | Previous, next window, repeatable   |
| prefix `h/j/k/l` | tmux   | Move to pane left, down, up, right  |
| prefix `w`       | fzf    | Pick any window across sessions     |
| prefix `p`       | tmux   | Previous window                     |
| `M-1` to `M-5`   | tmux   | Jump to window 1 to 5, no prefix    |
| prefix `K`       | sesh   | Session picker through sesh and fzf |

### Copy mode

The mouse is off, so selection is keyboard only.

| Key             | Plugin | Does                                                          |
| --------------- | ------ | ------------------------------------------------------------- |
| `M-v`           | tmux   | Enter copy mode, no prefix (crmux scroll mode inside crmux)   |
| prefix `v`      | tmux   | Enter copy mode (crmux scroll mode inside crmux)              |
| `v`             | tmux   | Start selection                                               |
| `V`             | tmux   | Select whole lines                                            |
| `<C-v>`         | tmux   | Toggle block selection                                        |
| `y`             | tmux   | Copy to the system clipboard and exit                         |
| `/` `?` `n` `N` | tmux   | Search the scrollback                                         |
| `q` or `<Esc>`  | tmux   | Leave without copying                                         |
| `<C-y>`         | tmux   | Copy the last tmux buffer to the clipboard, outside copy mode |

`y` pipes to `pbcopy` on macOS and `xclip` on Linux. Over ssh, nvim yanks travel
by OSC 52 instead.

### crmux

Sidebar for Claude Code sessions, from [my fork](https://github.com/AvhiMaz/crmux).

| Key                       | Plugin | Does                                                  |
| ------------------------- | ------ | ----------------------------------------------------- |
| `j` / `k`                 | crmux  | Next, previous session                                |
| `1` to `9`                | crmux  | Select session by number                              |
| `t`                       | crmux  | Back to the previously selected session               |
| `i`                       | crmux  | Type into the selected session, `<Esc>` to stop       |
| `s`                       | crmux  | Switch to the session's real window                   |
| `y`                       | crmux  | Copy mode in the session, back to crmux when done     |
| `<C-u>`                   | crmux  | Scroll mode: `j/k`, `<C-u>/<C-d>`, `gg`, `G`, `<Esc>` |
| `b`                       | crmux  | Hide or show the session list                         |
| `v`                       | crmux  | Cycle preview layout                                  |
| `e`                       | crmux  | Set a title for the session                           |
| `?` / `q`                 | crmux  | Help, quit                                            |

## Ghostty

| Key                           | Does                       |
| ----------------------------- | -------------------------- |
| `Cmd+Shift+H` / `Cmd+Shift+L` | Previous, next tmux window |

tmux has no Cmd modifier, so these send the prefix followed by `H` or `L`.
`macos-option-as-alt` is on, which is what makes the `M-` bindings above work.

## zsh

Vi mode is on, so `Esc` gives you normal mode at the prompt.

| Key         | Does                              |
| ----------- | --------------------------------- |
| `<C-Space>` | Accept the autosuggestion         |
| `Alt+→`     | Accept one word of it, macOS only |

| Command          | Does                                                          |
| ---------------- | ------------------------------------------------------------- |
| `vf`             | fzf over files with a bat preview, opens the pick in nvim     |
| `cdf [dir]`      | fzf over directories under `~/Dev`, cds into the pick         |
| `td`             | Attach the `dev` tmux session, creating it with five windows  |
| `tmux-dev`       | Attach the `personal` session in `~/Dev/personal`, macOS only |
| `change-manager` | Switch the current project between npm, pnpm and bun          |

`todo` is a small todo list in `~/.todos.txt`:

| Command           | Short    | Does                   |
| ----------------- | -------- | ---------------------- |
| `todo add <task>` | `todo a` | Add a task             |
| `todo list`       | `todo l` | Pending tasks          |
| `todo all`        |          | Pending and completed  |
| `todo done <n>`   | `todo d` | Mark task `n` as done  |
| `todo remove <n>` | `todo r` | Remove task `n`        |
| `todo clear`      | `todo c` | Remove completed tasks |
| `todo stats`      | `todo s` | Counts                 |

Aliases: `v` `vi` `vim` for nvim, `c` clear, `ll` for `ls -lah`, `g` git with
`ga` `gc` `gp` `gi` `gcl`, `ni` `nrd` `nrb` `nrs` for npm, `pi` `prd` `prb`
`prs` for pnpm, `ab` `at` for anchor, `tk` to kill the tmux server.

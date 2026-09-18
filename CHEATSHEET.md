# Cheatsheet

Every binding in this repo that is not a vim or tmux default. Leader is `Space`.

## Neovim

### Core

| Key           | Does                                  |
| ------------- | ------------------------------------- |
| `;`           | Enter command mode, no shift needed   |
| `jk`          | Escape, from insert                   |
| `<C-h/j/k/l>` | Move to window left, down, up, right  |
| `<C-\>`       | Jump to the compilation window        |
| arrow keys    | Disabled in normal, insert and visual |

On macOS `<C-k>` is also the tmux prefix, so tmux eats it first. Press `<C-k>`
twice to reach the nvim window-up mapping.

### Files and search

Telescope, all under `<leader>f`.

| Key                         | Does                                          |
| --------------------------- | --------------------------------------------- |
| `<leader>ff`                | Find files in cwd                             |
| `<leader>fF`                | Pick a directory first, then find files in it |
| `<leader>fA`                | Find files anywhere, outside the project      |
| `<leader>fw` / `<leader>fg` | Live grep                                     |
| `<leader>fb`                | Buffers                                       |
| `<leader>fh`                | Help tags                                     |
| `<leader>fo`                | Recent files                                  |
| `<leader>fy`                | Yank history, from neoclip                    |

### Harpoon

| Key                        | Does                         |
| -------------------------- | ---------------------------- |
| `<leader>a`                | Add current file to the list |
| `<C-e>`                    | Toggle tue quick menu        |
| `<leader>1` .. `<leader>4` | Jump to slot 1 to 4          |
| `<leader>hc`               | Clear the whole list         |

In the quick menu it is a normal buffer: `dd` removes an entry, `ddp` reorders,
then `:w` to save. `q` and `<Esc>` close without saving, so a deletion you did
not write is discarded.

### File explorer

`<leader>e` opens oil in the current window. The preview opens on its own and
follows the cursor.

| Key                         | Does                                            |
| --------------------------- | ----------------------------------------------- |
| `<CR>`                      | Open the entry                                  |
| `-`                         | Go to parent directory                          |
| `_`                         | Open cwd                                        |
| `` ` ``                     | `cd` to this directory                          |
| `<C-s>` / `<C-h>` / `<C-t>` | Open in vertical split, horizontal split, tab   |
| `<C-p>`                     | Toggle the preview                              |
| `<C-l>`                     | Refresh                                         |
| `<C-c>`                     | Close oil                                       |
| `gs`                        | Change sort                                     |
| `g.`                        | Toggle hidden files, already on by default here |
| `gx`                        | Open with the system handler                    |
| `g?`                        | Show all oil keymaps                            |

Oil edits the filesystem through the buffer: rename a line, `dd` to delete, `p`
to copy, then `:w` to apply. It asks for confirmation first.

### LSP

Buffer-local, active once a server attaches.

| Key          | Does                              |
| ------------ | --------------------------------- |
| `gd`         | Definition                        |
| `gD`         | Declaration                       |
| `gi`         | Implementation                    |
| `gr`         | References                        |
| `K`          | Hover docs                        |
| `<C-k>`      | Signature help, insert mode       |
| `<leader>ca` | Code action, normal and visual    |
| `<leader>rn` | Rename symbol                     |
| `<leader>lf` | Format with conform, LSP fallback |

Rust goes through rustaceanvim, which attaches rust-analyzer with the same maps.
Formatting also runs automatically on save through conform.

### Diagnostics

| Key          | Does                                   |
| ------------ | -------------------------------------- |
| `[d` / `]d`  | Previous, next diagnostic with a float |
| `<leader>df` | Show the diagnostic under the cursor   |
| `<leader>dl` | Send diagnostics to the location list  |
| `<leader>dq` | Send diagnostics to the quickfix list  |
| `<leader>dt` | Browse diagnostics in Telescope        |

### Completion

nvim-cmp, insert mode.

| Key                 | Does                                          |
| ------------------- | --------------------------------------------- |
| `<Tab>` / `<S-Tab>` | Next, previous item, also jumps snippet stops |
| `<CR>`              | Confirm the selected item                     |
| `<C-Space>`         | Trigger completion                            |
| `<C-e>`             | Abort                                         |

The command line completes too: `:` history, and zsh history on `:!` lines.
Wilder renders the `:`, `/` and `?` wildmenu with fuzzy matching.

### Copilot

Insert mode, inline suggestions only, no panel.

| Key     | Does                  |
| ------- | --------------------- |
| `<C-l>` | Accept the suggestion |
| `<C-g>` | Next suggestion       |
| `<C-x>` | Dismiss               |

The lualine section shows yellow when the Copilot client is attached and grey
when it is not.

### Git

| Key          | Does                              |
| ------------ | --------------------------------- |
| `<leader>gg` | LazyGit                           |
| `<leader>gs` | Fugitive status                   |
| `<leader>gc` | Commit                            |
| `<leader>gp` | Push                              |
| `<leader>gl` | Pull                              |
| `<leader>gd` | Diff against the index in a split |

Gitsigns draws the signs in the gutter, no mappings. Oil shows git status per
file in its own sign column. `:Octo` handles GitHub issues and pull requests.

### Compile mode

| Key          | Does                                         |
| ------------ | -------------------------------------------- |
| `<leader>cc` | Compile, prompts for the command             |
| `<leader>cr` | Recompile with the last command              |
| `<leader>ch` | Command history                              |
| `<C-\>`      | Jump to the compilation window from anywhere |

Inside the compilation buffer:

| Key     | Does                                                       |
| ------- | ---------------------------------------------------------- |
| `<CR>`  | Jump to the error under the cursor, reusing an open window |
| `<C-q>` | Send errors to the quickfix list and open it               |
| `<C-\>` | Jump back to the code                                      |
| `i`     | Send a line to the running program's stdin                 |
| `<C-d>` | Send EOF to the running program                            |

### Misc

| Key         | Does     |
| ----------- | -------- |
| `<leader>u` | Undotree |

## tmux

Prefix is `C-k` on macOS and `C-s` on Linux, so a nested session is always
reachable. Press the prefix twice to send it through to the inner program.

### Windows and panes

| Key              | Does                                |
| ---------------- | ----------------------------------- |
| `M-h` / `M-l`    | Previous, next window, no prefix    |
| prefix `H` / `L` | Previous, next window, repeatable   |
| prefix `h/j/k/l` | Move to pane left, down, up, right  |
| prefix `w`       | Window and pane tree                |
| prefix `K`       | Session picker through sesh and fzf |

### Copy mode

The mouse is off, so selection is keyboard only.

| Key             | Does                                                          |
| --------------- | ------------------------------------------------------------- |
| `M-v`           | Enter copy mode, no prefix                                    |
| prefix `v`      | Enter copy mode                                               |
| `v`             | Start selection                                               |
| `V`             | Select whole lines                                            |
| `<C-v>`         | Toggle block selection                                        |
| `y`             | Copy to the system clipboard and exit                         |
| `/` `?` `n` `N` | Search the scrollback                                         |
| `q` or `<Esc>`  | Leave without copying                                         |
| `<C-y>`         | Copy the last tmux buffer to the clipboard, outside copy mode |

`y` pipes to `pbcopy` on macOS and `xclip` on Linux. Over ssh, nvim yanks travel
by OSC 52 instead.

## Ghostty

| Key                           | Does                       |
| ----------------------------- | -------------------------- |
| `Cmd+Shift+H` / `Cmd+Shift+L` | Previous, next tmux window |

tmux has no Cmd modifier, so these send the prefix followed by `H` or `L`.
`macos-option-as-alt` is on, which is what makes the `M-` bindings above work.

## zsh

Vi mode is on, so `Esc` gives you normal mode at the prompt.

| Key         | Does                      |
| ----------- | ------------------------- |
| `<C-Space>` | Accept the autosuggestion |

| Command     | Does                                                      |
| ----------- | --------------------------------------------------------- |
| `vf`        | fzf over files with a bat preview, opens the pick in nvim |
| `cdf [dir]` | fzf over directories under `~/Dev`, cds into the pick     |
| `td`        | Attach the `dev` tmux session, creating it if needed      |
| `todo`      | Todo list                                                 |

Aliases: `v` `vi` `vim` for nvim, `c` clear, `ll` for `ls -lah`, `g` git with
`ga` `gc` `gp` `gi` `gcl`, `ni` `nrd` `nrb` `nrs` for npm, `pi` `prd` `prb`
`prs` for pnpm, `ab` `at` for anchor, `tk` to kill the tmux server.

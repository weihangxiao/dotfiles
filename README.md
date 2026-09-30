# Terminal setup

Ghostty + zsh + Neovim + tmux, based on [kunchenguid/dotfiles](https://github.com/kunchenguid/dotfiles) (Rosé Pine Moon everywhere).

## Install on a new Mac

```bash
git clone https://github.com/weihangxiao/dotfiles.git ~/dotfiles && cd ~/dotfiles && bash install.sh
```

(On a brand-new Mac, `git` itself triggers the Xcode Command Line Tools install — accept the popup, then run the command again.)

If Xcode Command Line Tools are missing, the script starts that install and exits — finish the popup, then run it again. Safe to re-run; existing configs are backed up as `*.bak-<timestamp>`.

## What it sets up

| Piece | Where | What |
|---|---|---|
| Homebrew | `~/.zprofile` | `brew shellenv` so `brew` is on PATH |
| Packages | Homebrew | starship, zsh-autosuggestions, zsh-syntax-highlighting, fzf, fd, ripgrep, lazygit, neovim, tmux, Hack Nerd Font, Ghostty |
| Ghostty | `~/.config/ghostty/config.ghostty` | Rose Pine Moon, Hack Nerd Font 15, 0.8 opacity + blur, dim unfocused splits, hidden titlebar |
| Prompt | `~/.config/starship.toml` | dir + git branch/status + duration, purple `❯` (red on error) |
| zsh | `~/.zshrc` (between `terminal-setup` markers) | Tab completion (case-insensitive, menu), fzf `Ctrl+R`/`Ctrl+T`, history suggestions (`Ctrl+F`/`→` accepts), syntax highlighting, aliases `..` `add` `push` `pull` `m`, `EDITOR=nvim` |
| Neovim | `~/.config/nvim` | Kun's config: rose-pine, snacks picker, oil, neogit, gitsigns, which-key, vim-tmux-navigator. **`Esc` saves, mouse off** |
| tmux | `~/.config/tmux/tmux.conf` | Prefix `Ctrl+A`; `\|` side-by-side / `-` stacked split; `Ctrl+hjkl` focus with no prefix (shared with Neovim via vim-tmux-navigator); `HJKL` resize; mouse on; Rosé Pine status bar on top; inactive panes dimmed; resurrect + continuum (auto-save every 15 min) |

## Cheat sheet

**Ghostty:** `Cmd+Enter` fullscreen · `Cmd+Shift+,` reload config · `Option`+drag window edge to move (titlebar is hidden)

**zsh:** `Tab` complete · `Ctrl+F` / `→` accept suggestion · `Ctrl+R` search history · `Ctrl+T` find file

**Neovim** (leader = Space): `␣f` files · `␣s` grep · `␣e` file browser · `␣b` buffers · `␣g` git · `Esc` save · `:q` quit

**Move between panes** (tmux and Neovim alike, no prefix): `Ctrl+H/J/K/L`

**tmux** (press `Ctrl+A`, release, then): `c` new window · `1-9` jump · `|` / `-` split · `H/J/K/L` resize · `z` zoom · `x` close pane · `d` detach · `Ctrl+L` clear screen · `Ctrl+S` / `Ctrl+R` save / restore · `r` reload config

## Not included

- Work-specific setup (`sai devsetup`, AWS, secret scanning) — run your company's onboarding on that machine.
- macOS: Caps Lock → Control (System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys) — recommended for `Ctrl+A`.

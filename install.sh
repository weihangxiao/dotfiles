#!/usr/bin/env bash
# Terminal setup: Ghostty + zsh (starship, autosuggestions, highlighting, fzf) + Neovim + tmux
# Safe to re-run. Existing config files are backed up to *.bak-<timestamp>.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
say() { printf '\n\033[1;35m==> %s\033[0m\n' "$*"; }

# 1. Xcode Command Line Tools (git, clang)
if ! xcode-select -p >/dev/null 2>&1; then
  say "Installing Xcode Command Line Tools — finish the popup, then re-run this script"
  xcode-select --install
  exit 0
fi

# 2. Homebrew
if [ -x /opt/homebrew/bin/brew ]; then BREW=/opt/homebrew/bin/brew
elif [ -x /usr/local/bin/brew ]; then BREW=/usr/local/bin/brew
else
  say "Installing Homebrew (asks for your password)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then BREW=/opt/homebrew/bin/brew; else BREW=/usr/local/bin/brew; fi
fi
eval "$("$BREW" shellenv)"
SHELLENV_LINE="eval \"\$($BREW shellenv zsh)\""
touch ~/.zprofile
grep -qF "$BREW shellenv" ~/.zprofile || printf '\n%s\n' "$SHELLENV_LINE" >> ~/.zprofile

# 3. Packages
say "Installing packages"
brew install starship zsh-autosuggestions zsh-syntax-highlighting fzf fd ripgrep lazygit neovim tmux
brew install --cask font-hack-nerd-font
[ -d /Applications/Ghostty.app ] || brew install --cask ghostty

# 4. Config files (backup anything already there)
place() { # place <src> <dest>
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && ! diff -rq "$src" "$dest" >/dev/null 2>&1; then
    mv "$dest" "$dest.bak-$TS"; echo "  backed up $dest -> $dest.bak-$TS"
  fi
  rm -rf "$dest"; cp -R "$src" "$dest"; echo "  installed $dest"
}
say "Copying config files"
place "$HERE/config/ghostty/config.ghostty" ~/.config/ghostty/config.ghostty
place "$HERE/config/starship.toml"          ~/.config/starship.toml
place "$HERE/config/tmux/tmux.conf"         ~/.config/tmux/tmux.conf
place "$HERE/config/nvim"                   ~/.config/nvim

# Ghostty's macOS-specific config loads *after* ~/.config and would override it
MAC_GHOSTTY="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
if [ -s "$MAC_GHOSTTY" ]; then
  mv "$MAC_GHOSTTY" "$MAC_GHOSTTY.bak-$TS"; echo "  moved aside $MAC_GHOSTTY (it would override)"
fi

# 5. zsh: append snippet once, between markers
say "Updating ~/.zshrc"
touch ~/.zshrc
if grep -q '>>> terminal-setup >>>' ~/.zshrc; then
  echo "  already present, skipping"
else
  { echo; echo '# >>> terminal-setup >>>'; cat "$HERE/zshrc-snippet.zsh"; echo '# <<< terminal-setup <<<'; } >> ~/.zshrc
  echo "  appended"
fi

# 6. tmux plugins (TPM + resurrect + continuum)
say "Installing tmux plugins"
for p in tpm tmux-resurrect tmux-continuum; do
  dest="$HOME/.config/tmux/plugins/$p"
  if [ -d "$dest" ]; then echo "  $p already installed"
  else git clone -q --depth 1 "https://github.com/tmux-plugins/$p" "$dest" && echo "  installed $p"; fi
done

# 7. Neovim plugins (pinned by lazy-lock.json)
say "Installing Neovim plugins"
nvim --headless "+Lazy! restore" +qa >/dev/null 2>&1 || echo "  (will finish on first nvim launch)"

say "Done. Quit Ghostty (Cmd+Q) and reopen it."

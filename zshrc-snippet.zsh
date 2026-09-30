# --- Ported from kunchenguid/dotfiles (home.nix) ---
command -v nvim >/dev/null && export EDITOR="nvim"

alias ..="cd .."
alias add="git add ."
alias push="git push"
alias pull="git pull"
alias m="git switch main"

# Tab completion (home-manager enables this implicitly)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' menu select                         # arrow keys through matches

# fzf: Ctrl+R history search, Ctrl+T file search
source <(fzf --zsh)

# Prompt
eval "$(starship init zsh)"

# Ghost-text suggestions from history; Ctrl+F accepts
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^f' autosuggest-accept

# Must be sourced last
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

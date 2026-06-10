export LANG="en_US.UTF-8"

# $LOCATION variable expected in ~/.zshenv
if [[ "$LOCATION" == "work" ]]; then
  echo "Loading Pax8 config from ~/.zshwork"
  source ~/.zshwork
fi



# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

plugins=(git)
ZSH_THEME="robbyrussell"

# fzf: use `fzf --zsh` where supported (recent fzf), else fall back to the
# Debian-packaged key-bindings, else nothing. Portable across macOS/Linux.
if command -v fzf >/dev/null 2>&1; then
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi

# zsh-autosuggestions: source from wherever it's installed (brew on macOS,
# /usr/share on Debian, or the oh-my-zsh custom plugin dir).
for _zsh_plugin in \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  [ -f "$_zsh_plugin" ] && source "$_zsh_plugin" && break
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ENV

# Colors for man pages/less
# Bold
export LESS_TERMCAP_mb=$'\e[1;35m'
export LESS_TERMCAP_md=$'\e[1;35m'
export LESS_TERMCAP_me=$'\e[0m'
# Standout/highlight
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44m'
# Underline
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;32m'

# ALIASES
alias ls='eza'
alias k='clear'
alias find_node='lsof -i :9000'
alias kill_node='kill -9'
alias session='~/dotfiles/.scripts/tmuxFrontendInitializer.sh'
alias python='python3'

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=500
HISTSIZE=499
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify


eval "$(zoxide init --cmd cd zsh)"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=252" # make suggested auto completes a bit brighter

# KEYBINDINGS
# up and down arrows to go through history, like "nvim <up/down>"
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh-syntax-highlighting (must be sourced near the end). Same portable lookup.
for _zsh_plugin in \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
  [ -f "$_zsh_plugin" ] && source "$_zsh_plugin" && break
done

# pyenv setup (python) — only if pyenv is actually installed
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init - zsh)"
fi

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.local/bin:$PATH"

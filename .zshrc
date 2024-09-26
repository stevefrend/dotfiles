# Apple terminal does not support true color etc.
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config '~/dotfiles/.config/ohmyposh/base.json')"
fi

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

plugins=(git)

source <(fzf --zsh)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ENV
# pax8
export AWS_PROFILE=sso
export CUBEJS_DB_USER=pax8
export CUBEJS_DB_PASS=jkT7NVwlE3?N6Jj8IH0mf#ts

# ALIASES
alias ls='ls -al --color'
alias c='clear'
alias find_node='lsof -i :9000'
alias kill_node='kill -9'
alias session='~/dotfiles/.scripts/tmuxFrontendInitializer.sh'

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

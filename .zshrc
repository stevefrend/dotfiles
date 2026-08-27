export LANG="en_US.UTF-8"

# Location-specific environment + secrets are sourced from ~/.zshenv (NOT here),
# so they reach non-interactive shells too — git hooks, GUI clients, scripts.
# ~/.zshenv sets LOCATION and sources the untracked ~/.zshenv.<location>.
# See .zshenv.example and .zshenv.work.example for the expected shape.


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

# nvm: lazy-load. Sourcing nvm.sh costs ~0.3s on every shell, so defer it until
# the first nvm/node/npm/npx/corepack call. The stubs source the real nvm.sh
# (which resolves the configured default, e.g. lts/*) then re-run the command,
# so behaviour is identical to eager loading -- just no startup cost.
#
# Each stub loads nvm.sh itself rather than calling a shared helper: tools that
# snapshot the shell (Claude Code, some IDE terminals) copy these stubs without
# the helper, and a stub that can't reach its loader recurses into itself until
# zsh dies on FUNCNEST. The command -v guard is the second belt -- if the command
# still isn't there after loading, fail with 127 instead of recursing.
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  for _cmd in nvm node npm npx corepack; do
    eval "${_cmd}() {
      unset -f nvm node npm npx corepack 2>/dev/null
      [ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"
      [ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\"
      if ! command -v ${_cmd} > /dev/null 2>&1; then
        print -u2 \"${_cmd}: not found after loading nvm (NVM_DIR=\$NVM_DIR)\"
        return 127
      fi
      ${_cmd} \"\$@\"
    }"
  done
  unset _cmd
fi

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
alias edit='~/dotfiles/.scripts/editorSession.sh'   # nvim | claude | hunk diff | zsh | zsh

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

# pyenv setup (python) — only if pyenv is actually installed.
# The shims resolve the right version (global / .python-version) on their own,
# so putting bin + shims on PATH makes python/pip work instantly. Defer the slow
# `pyenv init - zsh` integration (~0.3s; auto-rehash, `pyenv shell`, completion)
# until the first `pyenv` command.
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
  pyenv() {
    unset -f pyenv
    eval "$(command pyenv init - zsh)"
    pyenv "$@"
  }
fi

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.local/bin:$PATH"

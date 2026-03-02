# Dotfiles

Personal dotfiles for macOS and Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/) for symlinks and [Ansible](https://www.ansible.com/) for provisioning.

## Quick Start (fresh machine)

```bash
git clone https://github.com/stevefrend/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh` will:
1. Install system prerequisites (Linux: via apt)
2. Install [Homebrew](https://brew.sh/)
3. Install Ansible via Homebrew
4. Run the Ansible playbook

Restart your terminal when done.

---

## What Gets Installed

| Role | Tools |
|------|-------|
| `packages` | neovim, tmux, lazygit, ripgrep, eza, fzf, zoxide, oh-my-posh, zsh + plugins, stow |
| `packages` (macOS) | alacritty, wezterm, aerospace, Nerd Fonts |
| `packages` (Linux) | system prereqs via apt + JetBrains Mono Nerd Font |
| `dotfiles` | symlinks all configs into `~` via stow |
| `shell` | sets zsh as default shell |
| `tmux` | installs TPM and tmux plugins |
| `version_managers` | pyenv, nvm, sdkman |
| `dev_tools` | Claude Code CLI (`@anthropic-ai/claude-code`) |
| `macos` | AeroSpace reminder (requires manual Accessibility grant) |

---

## Running Parts of the Playbook

After bootstrap you can re-run individual roles using tags:

```bash
# Full run
ansible-playbook -i ansible/inventory/localhost.yml ansible/setup.yml

# Symlink dotfiles only
ansible-playbook -i ansible/inventory/localhost.yml ansible/setup.yml --tags dotfiles

# Install packages only
ansible-playbook -i ansible/inventory/localhost.yml ansible/setup.yml --tags packages

# Shell + tmux only
ansible-playbook -i ansible/inventory/localhost.yml ansible/setup.yml --tags "shell,tmux"

# Dry run (no changes made)
ansible-playbook -i ansible/inventory/localhost.yml ansible/setup.yml --check --diff
```

Available tags: `homebrew`, `packages`, `dotfiles`, `shell`, `tmux`, `version_managers`, `dev_tools`, `macos`

---

## Structure

```
dotfiles/
├── ansible/
│   ├── setup.yml               # Main playbook
│   ├── inventory/localhost.yml
│   ├── group_vars/all.yml      # Package lists and variables
│   ├── requirements.yml        # Ansible collections
│   └── roles/
│       ├── homebrew/           # Install Homebrew
│       ├── packages/           # Install all packages
│       ├── dotfiles/           # Stow symlinks
│       ├── shell/              # Set zsh as default
│       ├── tmux/               # TPM + plugins
│       ├── version_managers/   # pyenv, nvm, sdkman
│       ├── dev_tools/          # Claude Code CLI
│       └── macos/              # macOS-only config
├── .config/
│   ├── aerospace/
│   ├── alacritty/
│   ├── lazygit/
│   ├── nvim/                   # LazyVim
│   └── ohmyposh/
├── .tmux.conf
├── .wezterm.lua
├── .zprofile
├── .zshrc
├── .scripts/
└── bootstrap.sh
```

---

## Manual Steps

A few things can't be automated:

- **AeroSpace** (macOS): Grant Accessibility permission on first launch via *System Settings → Privacy & Security → Accessibility*
- **Neovim plugins**: Launch `nvim` once — LazyVim will auto-install all plugins on first open
- **Work config**: Set `export LOCATION=work` in `~/.zshenv` to load `~/.zshwork`

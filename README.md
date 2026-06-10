# Dotfiles

Managed with GNU Stow + Ansible.

## Quick Start

### Fresh machine (macOS or Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/stevefrend/dotfiles/main/ansible-pull.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/stevefrend/dotfiles.git ~/dotfiles
cd ~/dotfiles
ansible-playbook ansible/playbook.yml
```

### Profiles

| Profile | Includes |
|---------|----------|
| `dev` (default) | Core shell + terminal + neovim + CLI tools + dev languages |
| `minimal` | Core shell + terminal + neovim + CLI tools (no node/python/go) |

```bash
# Headless server — minimal profile
./ansible-pull.sh https://github.com/stevefrend/dotfiles.git minimal

# Add Docker to a minimal machine ad-hoc
./ansible-pull.sh https://github.com/stevefrend/dotfiles.git minimal,docker

# Work machine with location flag
./ansible-pull.sh https://github.com/stevefrend/dotfiles.git dev work
```

### Per-machine config

Set `$LOCATION` in `~/.zshenv` (rendered from template):

- `home` — personal machines (default)
- `work` — sources `~/.zshwork` for work-specific config

Override per machine with `--extra-vars "location=work"` or via `host_vars/`.

## What It Sets Up

- **zsh** + Oh My Zsh + autosuggestions + syntax highlighting
- **tmux** with TPM, resurrect, continuum, vim navigation, catppuccin theme
- **wezterm** terminal (macOS)
- **neovim** with full LazyVim config
- **CLI tools**: eza, fzf, zoxide, ripgrep, gh, lazygit, tldr
- **Dev languages**: nvm/node, pyenv/python, go, sdkman/java (dev profile only)
- **Docker** (dev profile + `--tags docker`)
- **Aerospace** tiling WM (macOS only)

## Testing

```bash
# Docker smoke test (Debian, minimal profile)
./ansible/test-with-docker.sh

# With different distro or tags
./ansible/test-with-docker.sh ubuntu:24.04 minimal,docker
```

## Structure

```
dotfiles/
├── ansible/
│   ├── playbook.yml       # Entry point
│   ├── roles/             # core, terminal, editors, tools, dev
│   ├── templates/         # Jinja2 templates (.zshrc, .zshenv, .gitconfig)
│   └── host_vars/         # Per-machine overrides
├── .config/               # Sync'd to ~/.config/ via Ansible
├── .tmux.conf             # Symlinked via stow
├── .wezterm.lua           # Symlinked via stow
├── .zshrc                 # Stow-managed (template overrides on first pull)
├── ansible-pull.sh        # Bootstrap script
└── README.md
```

# Dotfiles

Managed with **GNU Stow** (config symlinks) + **Ansible** (package installs).

The split is deliberate:

- **Stow** owns every config file. `~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim`, … are symlinks
  into this repo. Ansible never writes them.
- **Ansible** only installs packages and runs `stow`. It's organised into small, **tag-based
  modules** you invoke individually — there are no monolithic "profiles" or roles.

Works on **macOS** and **Debian/Linux**.

## Quick start

```bash
git clone https://github.com/stevefrend/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install the base environment (zsh, tmux, neovim, CLI tools, git config) + symlink dotfiles
ansible-playbook ansible/playbook.yml --tags foundations
```

Bootstrapping a fresh box (installs Ansible first, then pulls and runs):

```bash
./ansible-pull.sh https://github.com/stevefrend/dotfiles.git foundations
```

## Modules

Run the whole base, or target one piece by tag:

```bash
ansible-playbook ansible/playbook.yml --tags foundations   # everything below
ansible-playbook ansible/playbook.yml --tags neovim        # just neovim
ansible-playbook ansible/playbook.yml --tags tmux,git      # compose several
```

| Tag           | Installs |
|---------------|----------|
| `foundations` | the whole base (all rows below) |
| `stow`        | GNU Stow + symlinks this repo into `$HOME` |
| `shell` / `zsh` | zsh, Oh My Zsh, autosuggestions, syntax-highlighting |
| `terminal` / `tmux` | tmux + TPM/resurrect/continuum/navigator/catppuccin; ghostty + Nerd Fonts (macOS) |
| `editor` / `neovim` | neovim |
| `tools`       | eza, fzf, zoxide, ripgrep, tldr, gh, lazygit |
| `git`         | git aliases + pull/push settings (idempotent; see below) |

### Git config

The `git` module sets safe aliases and pull/push behaviour every run. It sets your
`user.name` / `user.email` **only if they aren't already configured globally**, so it never
clobbers an existing identity. Defaults are the personal identity; a work identity is **not**
committed to this repo — set it per-machine via `--extra-vars` or an untracked
`ansible/local.vars.yml` (copy `ansible/local.vars.yml.example`).

## Testing on Debian (colima-safe)

A lightweight throwaway container runs the playbook over a **local connection** — no sshd, no
privileged caps, native arch. It's just one small container and won't disturb colima or your
other running containers.

```bash
./ansible/testbox.sh up                        # build + start
./ansible/testbox.sh check                      # dry-run (--check --diff)
./ansible/testbox.sh ansible --tags foundations # apply
./ansible/testbox.sh shell                      # poke around (run nvim, tmux, ...)
./ansible/testbox.sh down                        # remove
```

## Adding a module (example: Go)

The pattern is intentionally small. Create `ansible/modules/go.yml`:

```yaml
---
- name: Install Go (macOS)
  community.general.homebrew: { name: go, state: present }
  when: ansible_system == "Darwin"

- name: Install Go (Linux)
  when: ansible_os_family == "Debian"
  block:
    - get_url: { url: https://go.dev/dl/go1.22.5.linux-amd64.tar.gz, dest: /tmp/go.tar.gz, mode: "0644" }
    - unarchive: { src: /tmp/go.tar.gz, dest: /usr/local, remote_src: true, creates: /usr/local/go }
      become: true
```

Then add one line to `ansible/playbook.yml` under `tasks:` (note: **not** tagged `foundations`,
so it stays opt-in):

```yaml
    - name: go
      import_tasks: modules/go.yml
      tags: [go]
```

Now `ansible-playbook ansible/playbook.yml --tags go` sets you up with Go.

## Structure

```
dotfiles/
├── ansible/
│   ├── playbook.yml              # entry point: tagged module imports
│   ├── ansible.cfg
│   ├── inventory.yml             # localhost / local connection
│   ├── modules/                  # stow, shell, terminal, editor, tools, git
│   ├── Dockerfile.testbox        # slim Debian test image
│   ├── testbox.sh                # up/check/ansible/shell/down
│   └── local.vars.yml.example    # untracked per-machine overrides
├── .config/                      # nvim, lazygit, aerospace, ghostty, ... (stow-managed)
├── .tmux.conf  .zshrc  .zprofile   # stow-managed
├── ansible-pull.sh               # bootstrap a fresh machine
└── README.md
```

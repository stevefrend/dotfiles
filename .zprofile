# Load Homebrew's environment if brew is installed. Probe the known locations
# (Apple Silicon, Intel mac, Linuxbrew) so this is portable across machines --
# brew isn't on PATH yet, so we can't just `command -v brew`.
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$_brew" ]; then
    eval "$("$_brew" shellenv)"
    break
  fi
done
unset _brew

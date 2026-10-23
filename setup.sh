#!/usr/bin/env bash
# Bootstrap the Neovim/AstroNvim setup on a fresh Mac (Apple Silicon or Intel).
# Safe to re-run: every step checks before it changes anything.
#
#   git clone https://github.com/lekenzi/myneovim_conf.git ~/dotfiles && ~/dotfiles/setup.sh
#
# Flags:
#   --skip-tools   skip the headless plugin + Mason install (do it on first nvim launch instead)

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKIP_TOOLS=0
[[ "${1:-}" == "--skip-tools" ]] && SKIP_TOOLS=1

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
ok()   { printf '\033[32m  ✓ %s\033[0m\n' "$*"; }
warn() { printf '\033[33m  ! %s\033[0m\n' "$*"; }

# Append a line to a file only if it isn't already there.
ensure_line() {
  local line="$1" file="$2"
  touch "$file"
  grep -qxF "$line" "$file" || printf '\n%s\n' "$line" >> "$file"
}

# Move an existing path aside (unless it's already our symlink), then symlink it to the repo.
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    ok "$dst already linked"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    local bak
    bak="$dst.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$bak"
    warn "backed up existing $dst -> $bak"
  fi
  ln -s "$src" "$dst"
  ok "linked $dst -> $src"
}

[[ "$(uname)" == "Darwin" ]] || { echo "This script is for macOS."; exit 1; }
# zsh/toolchains.zsh is sourced from ~/.zshrc by this fixed path.
[[ "$DOTFILES" == "$HOME/dotfiles" ]] || { echo "Clone this repo to ~/dotfiles (found at $DOTFILES)."; exit 1; }

step "Xcode Command Line Tools"
if xcode-select -p >/dev/null 2>&1; then
  ok "already installed"
else
  xcode-select --install || true
  echo "  Finish the installer dialog, then press Enter to continue."
  read -r
fi

step "Homebrew"
if [[ -x /opt/homebrew/bin/brew ]]; then BREW=/opt/homebrew/bin/brew
elif [[ -x /usr/local/bin/brew ]]; then BREW=/usr/local/bin/brew
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW=$([[ -x /opt/homebrew/bin/brew ]] && echo /opt/homebrew/bin/brew || echo /usr/local/bin/brew)
fi
eval "$("$BREW" shellenv)"
# Puts Homebrew ahead of /usr/bin so `python3` etc. resolve to Homebrew, not the old macOS copies.
ensure_line "eval \"\$($BREW shellenv)\"" "$HOME/.zprofile"
ok "$(brew --version | head -1)"

step "Packages (Brewfile)"
brew bundle --file "$DOTFILES/Brewfile"

step "Rust toolchain"
RUSTUP="$(brew --prefix rustup)/bin/rustup"
"$RUSTUP" default stable
"$RUSTUP" component add rust-analyzer
ok "$("$(brew --prefix rustup)/bin/rustc" --version)"

step "Shell config"
# shellcheck disable=SC2016  # literal $HOME, expanded when zsh starts
ensure_line '[ -f "$HOME/dotfiles/zsh/toolchains.zsh" ] && source "$HOME/dotfiles/zsh/toolchains.zsh"' "$HOME/.zshrc"
# toolchains.zsh hardcodes /opt/homebrew; on Intel Macs Homebrew lives in /usr/local.
if [[ "$(brew --prefix)" != "/opt/homebrew" ]]; then
  warn "Intel Mac detected: edit $DOTFILES/zsh/toolchains.zsh and replace /opt/homebrew with $(brew --prefix)"
fi
# shellcheck disable=SC1091
source "$DOTFILES/zsh/toolchains.zsh"
ok "zprofile and zshrc updated"

step "Neovim config"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/docs/Neovim-Guide.md" "$HOME/Desktop/Neovim-Guide.md"

if [[ $SKIP_TOOLS -eq 0 ]]; then
  step "Plugins (pinned by nvim/lazy-lock.json)"
  nvim --headless "+Lazy! restore" +qa
  ok "plugins installed"

  step "Language servers, formatters, debuggers (Mason)"
  nvim --headless "+MasonToolsInstallSync" +qa
  ok "$(find "$HOME/.local/share/nvim/mason/packages" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' ') Mason packages installed"
fi

step "Done"
cat <<'EOF'
  1. Set your terminal font to "JetBrainsMono Nerd Font" (otherwise icons show as boxes).
  2. Open a new terminal tab so the PATH changes apply.
  3. Run: nvim ~/Desktop/Neovim-Guide.md
EOF

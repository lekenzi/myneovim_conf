# Change log

Every change made to this Mac while setting up Neovim, in order, with the reason.
Made by Claude (Claude Opus 5.5, via Claude Code) on **2026-10-23**.

## 1. AstroNvim installed

- **Starting state:** Neovim 0.12.6 (Homebrew), no existing config. `~/.local/share/nvim` and `~/.local/state/nvim` were empty, so there was nothing to back up.
- Cloned the official [AstroNvim template](https://github.com/AstroNvim/template) into `~/.config/nvim` and removed its `.git` so the config is yours.
- Installed all plugins headlessly (`Lazy! sync`) so the first launch is instant.

## 2. Homebrew packages

| Package | Why |
|---|---|
| `ripgrep` | Project-wide search (`Space fw`) |
| `lazygit` | Git UI (`Space gg`) |
| `node` | JS/TS/Vue tooling; many language servers are Node programs |
| `tree-sitter-cli` | Compiles syntax parsers |
| `bottom` | System monitor terminal (`Space tt`) |
| `gdu` | Disk usage terminal (`Space tu`); installed as `gdu-go` to avoid a clash with coreutils |
| `go` | Go toolchain; Mason builds `gopls` and Go tools with it |
| `rustup` | Rust toolchain manager; `stable` 1.99 + `rust-analyzer` component installed |
| `openjdk@21` | `jdtls` (the Java language server) needs Java 21+; macOS had only a stub `java` |
| `font-jetbrains-mono-nerd-font` (cask) | Icons in the UI |

`python@3.13` was installed by mistake and then **uninstalled**: Homebrew's `python@3.15` was already present.

## 3. Shell configuration

- **`~/.zprofile` (new file):** `eval "$(/opt/homebrew/bin/brew shellenv)"`
  **Why:** Homebrew's shell setup was missing, so `/usr/bin` came before `/opt/homebrew/bin` and `python3` resolved to the old macOS Python 3.9.
- **`~/.zshrc` (appended):** one line that sources `~/dotfiles/zsh/toolchains.zsh`.
  **Why:** `rustup` and `openjdk@21` are keg-only (Homebrew doesn't link them onto PATH), and `go install` puts binaries in `~/go/bin`. That file also sets `JAVA_HOME`.

## 4. Language packs (`nvim/lua/community.lua`)

Enabled AstroCommunity packs: `lua`, `go`, `rust`, `cpp` (C and C++), `python.base` + `python.basedpyright` + `python.ruff`, `typescript` (JS/TS/React), `vue`, `html-css`, `prettier`, `java`, `bash`, `terraform` (HCL), `docker`, `json`, `yaml`, `toml`, `markdown`.

For Python, basedpyright + ruff was chosen over the default black + isort because it's faster and a single tool.

Mason installed 39 tools: basedpyright, bash-debug-adapter, bash-language-server, clangd, codelldb, css-lsp, debugpy, delve, docker-language-server, emmet-ls, goimports, gomodifytags, gopls, gotests, hadolint, html-lsp, iferr, impl, java-debug-adapter, java-test, jdtls, js-debug-adapter, json-lsp, lemminx, lua-language-server, marksman, prettierd, ruff, selene, shellcheck, shfmt, stylua, taplo, terraform-ls, tflint, tfsec, vtsls, vue-language-server, yaml-language-server.

**Verified:** opening a test file attached the right language server for Go (gopls), Python (basedpyright, ruff), C (clangd), TSX (vtsls, emmet), Terraform (terraformls, tflint), Bash (bashls) and Rust (rust-analyzer). Java and Vue weren't tested because they need a real project folder.

## 5. Learning guide

`docs/Neovim-Guide.md`, symlinked to `~/Desktop/Neovim-Guide.md`. Every keybinding in it was taken from the installed config, not from AstroNvim's docs.

## 6. This repo (`~/dotfiles`)

- Moved `~/.config/nvim` to `~/dotfiles/nvim` and symlinked it back.
- Moved the guide from the Desktop into `docs/` and symlinked it back.
- Moved the toolchain lines from `~/.zshrc` into `zsh/toolchains.zsh`.
- Added `Brewfile`, `setup.sh`, `README.md`, this file, `CLAUDE.md` / `AGENTS.md`.
- `git init` with a first commit. **Not pushed anywhere.**

## Undo everything

```sh
rm ~/.config/nvim ~/Desktop/Neovim-Guide.md          # symlinks only
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
rm ~/.zprofile                                        # did not exist before
# delete the "Neovim language toolchains" lines at the end of ~/.zshrc
brew uninstall lazygit tree-sitter-cli bottom gdu go rustup openjdk@21
brew uninstall --cask font-jetbrains-mono-nerd-font
rm -rf ~/.rustup                                      # Rust toolchains
```

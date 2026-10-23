# Instructions for AI agents (Claude Code, Codex, Cursor, etc.)

This repo is the owner's macOS Neovim setup: AstroNvim v6 on Neovim 0.12. Read `README.md` for the layout and `CHANGES.md` for what has been changed on the machine and why.

## Owner context

- Languages: Go, Rust, C, C++, Python, Bash, Terraform/HCL; sometimes React, Vue, JS/TS, Java.
- Learning Neovim. Keep `docs/Neovim-Guide.md` beginner-friendly and accurate.

## Setting up a new Mac

Run `./setup.sh` (it's idempotent). If it fails partway, fix the cause and re-run it; don't run the steps by hand in a different way. On Intel Macs, replace `/opt/homebrew` in `zsh/toolchains.zsh` with `/usr/local`.

## Rules

- **Symlinks:** `~/.config/nvim` → `nvim/`, `~/Desktop/Neovim-Guide.md` → `docs/Neovim-Guide.md`. Edit files in the repo, never replace a symlink with a copy.
- **Languages:** add or remove `astrocommunity.pack.*` imports in `nvim/lua/community.lua`. Check that a pack exists in the [AstroCommunity repo](https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack) before adding it. If a pack needs a system toolchain, add it to `Brewfile` too.
- **Keybindings in the guide** must match the real config. Dump them before documenting:
  `nvim --headless file.ext '+lua vim.defer_fn(function() for _,k in ipairs(vim.api.nvim_get_keymap("n")) do if k.desc then print(k.lhs, k.desc) end end vim.cmd("qa!") end, 5000)'`
  Buffer-local LSP keys need `nvim_buf_get_keymap(0, "n")` with a real source file open.
- **Verify headlessly** after config changes: `nvim --headless "+Lazy! sync" +qa`, then `nvim --headless "+MasonToolsInstallSync" +qa`. Check that a language server attaches via `vim.lsp.get_clients({bufnr=0})`.
- **Plugin versions:** after updating, commit `nvim/lazy-lock.json`. `setup.sh` uses `Lazy! restore` so new machines match it.
- **Shell files:** don't edit `~/.zshrc` beyond the single source line. Put shell config in `zsh/`.
- **Record machine-level changes** (Homebrew packages, shell files, anything outside this repo) in `CHANGES.md`.
- Don't push or add a git remote without asking the owner.

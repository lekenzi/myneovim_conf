# dotfiles

My Neovim development setup for macOS: [AstroNvim](https://docs.astronvim.com) v6 on Neovim 0.12, with full language support (LSP, formatting, linting, debugging) for:

**Go · Rust · C · C++ · Python · JavaScript · TypeScript · React · Vue · Java · Bash · Terraform/HCL**
plus JSON, YAML, TOML, Markdown, Docker, HTML/CSS and Lua.

## New Mac in one command

```sh
git clone <this-repo-url> ~/dotfiles && ~/dotfiles/setup.sh
```

Then set your terminal font to **JetBrainsMono Nerd Font** and open a new terminal tab.

`setup.sh` is safe to re-run. It installs Homebrew + everything in the `Brewfile`, sets up Rust and Java, adds a few lines to your zsh config, symlinks the Neovim config, and pre-installs every plugin and language server. Anything already in its way is backed up as `*.bak.<timestamp>`, never deleted.

## Layout

| Path | What it is | Linked to |
|---|---|---|
| `nvim/` | AstroNvim config (`lua/community.lua` holds the language packs) | `~/.config/nvim` |
| `nvim/lazy-lock.json` | Exact plugin versions, so a new machine gets the same setup | |
| `zsh/toolchains.zsh` | PATH for rustup, Java 21, Go binaries | sourced from `~/.zshrc` |
| `Brewfile` | Every Homebrew package the setup needs | |
| `setup.sh` | Bootstrap script for a new Mac | |
| `docs/Neovim-Guide.md` | How to learn and use this setup efficiently | `~/Desktop/Neovim-Guide.md` |
| `CHANGES.md` | Log of every change made to the machine, and why | |
| `CLAUDE.md` / `AGENTS.md` | Instructions for AI coding agents working on this repo | |

## Day-to-day

- Update plugins + language servers: `Space pa` in Neovim, then commit `nvim/lazy-lock.json`.
- Add a language: add an `astrocommunity.pack.<name>` import to `nvim/lua/community.lua` ([list of packs](https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack)).
- Problems: `:checkhealth` in Neovim.

## Credits

Set up and documented by **Claude** (Anthropic's Claude Opus 5.5, via [Claude Code](https://claude.com/claude-code)) on 2026-10-23, at the request of [@lekenzi](https://github.com/lekenzi).
Built on [AstroNvim](https://github.com/AstroNvim/AstroNvim) and [AstroCommunity](https://github.com/AstroNvim/astrocommunity).

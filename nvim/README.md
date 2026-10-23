# Neovim config

AstroNvim v6 user config, based on the [AstroNvim template](https://github.com/AstroNvim/template).
It lives in `~/dotfiles/nvim` and `~/.config/nvim` symlinks to it. See `../README.md` for setup and `../docs/Neovim-Guide.md` for usage.

- `lua/community.lua`: language packs
- `lua/plugins/*.lua`: your own settings (delete the `if true then return {} end` line at the top of a file to turn it on)
- `lazy-lock.json`: pinned plugin versions

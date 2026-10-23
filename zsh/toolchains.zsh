# Language toolchains for Neovim/AstroNvim (managed by ~/dotfiles)
# rustup and openjdk@21 are keg-only in Homebrew, so they need explicit PATH entries.
export PATH="/opt/homebrew/opt/rustup/bin:$HOME/.cargo/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$HOME/go/bin:$PATH"

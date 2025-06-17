# .zshrc

### Plugin Manager ###

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Install starship
zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
zinit light starship/starship

# Removes duplicate entries
typeset -U path

# User specific environment
path=(~/.local/bin ~/bin $path)

# Export PATH to ensure it's available to child processes
export PATH

# Set Neovim as the default text editor for terminal applications
export EDITOR="nvim"
export VISUAL="nvim"

# Set vim mode
bindkey -v

# Set bat theme
export BAT_THEME="base16"

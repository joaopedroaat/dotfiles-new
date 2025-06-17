# .zshrc

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

# Set up Starship
eval "$(starship init zsh)" # Place it always at the bottom

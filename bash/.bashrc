# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Set Neovim as the default text editor for terminal applications
export EDITOR="nvim"
export VISUAL="nvim"

# Set vim mode
set -o vi

# Set up Starship
# NEEDS TO BE ALWAYS AT THE BOTTOM
eval "$(starship init bash)"

# .zshrc

# Remove duplicate entries from PATH
typeset -U path

# Define GOPATH
export GOPATH="$HOME/.go"

# Construct the PATH:
# 1. User-specific binaries (highest priority)
# 2. Go binaries
# 3. Existing system PATH
path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "$GOPATH/bin"
    $path
)

# Export the final PATH
export PATH

# Setup Neovim as the default text editor for terminal applications
export EDITOR="nvim"
export VISUAL="nvim"

# Setup bat theme
export BAT_THEME="base16"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Set starship
zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
zinit light starship/starship

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab # Make sure fzf is installed!

# Snippets
zinit snippet OMZP::git # oh-my-zsh git plugin
zinit snippet OMZP::sudo # oh-my-zsh sudo plugin
zinit snippet OMZP::command-not-found # oh-my-zsh command-not-found plugin
zinit snippet OMZP::dnf # oh-my-zsh dnf plugin

# Load completions
autoload -Uz compinit && compinit

# I don't know what it does but the performance gains are huge
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

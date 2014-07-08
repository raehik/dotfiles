source $HOME/.shellrc
source $HOME/.zsh_theme

# Load zsh's great completion features
autoload -U compinit && compinit

# Vi-style command-line editing
bindkey -v

# Select your completion from a clear menu (inverted background on selection)
# You can also move around selections by hitting the arrow keys.
zstyle ':completion:*:*:*:*:*' menu select

# make zsh's completion use LS_COLORS too! :D
# it's only set when this command is run, though, so chainging LS_COLORS
# without re-running this command won't help.
# (stolen from oh-my-zsh)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# For some reason, kill completion doesn't show up many processes to kill.
# We'll fix that.
# (stolen from oh-my-zsh)
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# Also, colour it cool.
# (stolen from oh-my-zsh)
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

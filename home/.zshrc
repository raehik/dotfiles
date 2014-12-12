# vim: set foldmethod=marker :
#
# zsh-specific shell configuration.
#

# source general config
source "$HOME/.shellrc"

# source shell theme
source "$HOME/.zsh_theme"

# load zsh's great completion features
autoload -U compinit && compinit

# Vi[m]-style command-line editing
bindkey -v

# Allow comments in interactive mode.
#
#     $ #command to run when I remember syntax
#     $ do this # but not this
#
setopt interactivecomments

## Custom completions {{{
# show a completion menu for commands, files etc. (move around using
# arrow keys)
zstyle ':completion:*:*:*:*:*' menu select

# make zsh's completion use $LS_COLORS
# (stolen from oh-my-zsh)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# show lots of processes with `kill` completion
# (stolen from oh-my-zsh)
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# & colour `kill` completion
# (stolen from oh-my-zsh)
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
## }}}

## Command history configuration {{{
# file name
HISTFILE=$HOME/.zsh_history

# ???
# for setting max no. of commands in history file
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# don't record duplicate lines or lines beginning with a space
# (same as bash HISTCONTROL=ignoreboth)
setopt hist_ignore_dups
setopt hist_ignore_space

# append to history every command
setopt inc_append_history

# actually share the history, between concurrent sessions
setopt share_history
## }}}

# don't do that dumb query before `rm path/*`
setopt rm_star_silent

# source my full-history-recording stuff
source $HOME/.zsh_record_full_hist

# set a custom 'zsh: command not found: $0' message
# args are the command args
#command_not_found_handler() {
#    echo "ayy lmao"
#}

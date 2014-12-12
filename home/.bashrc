#
# bash-specific shell configuration.
#

# source general config
source "$HOME/.shellrc"

# source shell theme
source "$HOME/.bash_theme"

# reset any dumb settings made by your distro (Arch Linux, why? :c)
PROMPT_COMMAND=

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# set number of history commands stored in memory
HISTSIZE=1000

# set number of history commands stored in the history file
HISTFILESIZE=2000

# check window size after each command and, if necessary, update $LINES
# and $COLUMNS
shopt -s checkwinsize

# '**' = match all files in *all subdirectories* of all directories
# (i.e. recurse all levels)
shopt -s globstar

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# enable programmable completion features (not necessary if already enabled in
# /etc/bash.bashrc, and /etc/profile sources that)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable ls colors
alias ls='ls --color=auto'

# Enable grep colors
alias grep='grep --color=auto'

# Useful ls aliases
alias ll='ls -lh'
alias la='ls -lah'
alias l='ls -la'

# Set the prompt
PS1='\[\033[0;32m\]\u@\h: \[\033[01;34m\]\w\[\033[00m\] \[\033[1;31m\]$\[\033[0m\] '

#!/usr/bin/env zsh
#
# A simple, easily configured theme for zsh.
#
# (the shebang is for Vim to understand what sort of file this is)
#

build_prompt() {
    # use a function so we don't leave vars all over the place
    # only PROMPT stays set

    # if you want to change up the colours, change these variables!
    local col_user="$fg_no_bold[green]"
    local col_at="$fg_bo_bold[green]"
    local char_at='@'
    local col_host="$fg_no_bold[green]"
    local col_colon="$fg_no_bold[green]"
    local char_colon=': '
    local col_pwd="$fg_bold[blue]"
    local col_prompt_success="$fg_bold[red]"
    local col_prompt_fail="$fg_no_bold[red]"
    local char_prompt='$ '
    local col_command="$reset_color"

    echo -n "%{$col_user%}%n%{$col_at%}$char_at%{$col_host%}%m%{$col_colon%}$char_colon%{$col_pwd%}%~ %(?:%{$col_prompt_success%}:%{$col_prompt_fail%})$char_prompt%{$col_command%}"
}

PROMPT='$(build_prompt)'
unset build_prompt

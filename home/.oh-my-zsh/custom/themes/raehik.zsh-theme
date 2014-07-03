#!/usr/bin/env zsh
#
# A simple, easily configured theme for zsh.
#
# (the shebang is for Vim to understand what sort of file this is)
#

build_prompt() {
    # use a function so we don't leave vars all over the place
    # only PROMPT stays set

    local git_colour git_bit

    # if you want to change up the colours, change these variables!
    local col_user="$fg_no_bold[green]"
    local col_at="$fg_bo_bold[green]"
    local char_at='@'
    local col_host="$fg_no_bold[green]"
    local col_colon="$fg_no_bold[green]"
    local char_colon=': '
    local col_pwd="$fg_bold[blue]"
    local col_prompt_0="$fg_bold[red]"
    local col_prompt_1="$fg_no_bold[red]"
    local char_prompt='$ '
    local col_command="$reset_color"

    # have to use double quotes (") because I'm using my own variables, but
    # that means (for whatever reason) git_prompt_info doesn't work, so I put
    # it into a variable instead.
    # also, these two things -really- slow my prompt down. mainly prompt_info.
    # I replaced them with my own mangling (it's actually reasonably neat).
    if $(git rev-parse --is-inside-work-tree &> /dev/null); then
        if [[ -n $(git status --porcelain) ]]; then
            # dirty
            git_status_colour="%{$fg_bold[yellow]%}"
        else
            # clean
            git_status_colour="%{$fg_no_bold[yellow]%}"
        fi

        git_bit="${git_status_colour}<$(git symbolic-ref --short HEAD)> "
    fi

    echo -n "%{$col_user%}%n%{$col_at%}$char_at%{$col_host%}%m%{$col_colon%}$char_colon%{$col_pwd%}%~ ${git_bit}%(?:%{$col_prompt_0%}:%{$col_prompt_1%})$char_prompt%{$col_command%}"
}

PROMPT='$(build_prompt)'
unset build_prompt

" Move viminfo to a cache dir instead of $HOME
set viminfo+=n~/.cache/viminfo

" Enable mouse in all modes
set mouse=a

" Set clipboard to system default (so yank/paste goes to main X
" clipboard)
"set clipboard=unnamedplus

" Switch from a buffer without being required to save it, and a bunch of
" other things.
" Very useful, does lots of things you'll probably want.
set hidden

" Show a cyclable completion menu for commands, filenames & more (think
" zsh)
set wildmenu

" Show incomplete commands in bottom-right of screen (e.g. 23y -- before
" hitting y again to complete yank command)
"set showcmd

" Be case insensitive when searching
set ignorecase

" ... except if using capital letters
set smartcase

" On save, backup the original file (filename with ~ appended)
set backup

" Directories to try to place backups in. If the first doesn't exist or
" can't be used, the next entry (separated by a comma) is used, etc.
set backupdir=~/.vim/backup,.

" Enable modeline (disabled by default because it is a common source of
" vulnerabilities)
set modeline

" Turn on filetype detection (using filename & sometimes file contents).
" Also enables custom indent per filetype (e.g. you type an if statement
" in Bash, the next line is indented).
filetype indent plugin on

" Always look for fold markers (useful so you don't *have* to write
" modelines, but they're still helpful and informative to people who
" don't have this setting, so keep using modelines for foldmethod too!)
set foldmethod=marker

" Never timeout on mappings (useful for <Leader> mappings!)
set notimeout

" Do timeout on keycodes (e.g. Esc)
set ttimeout

" Enable omni completion
"set omnifunc=syntaxcomplete#Complete

" Set spelling language
set spelllang=en_gb

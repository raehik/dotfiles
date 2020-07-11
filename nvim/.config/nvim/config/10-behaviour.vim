" Input and behaviour settings.

" Hide buffers instead of closing (which often forces a save). Also does some
" other related things. Should be a default.
set hidden

" Be case insensitive when searching, except if using capital letters
set ignorecase smartcase

" On save, backup the original file (filename with ~ appended)
set backup backupdir=$XDG_DATA_HOME/nvim/backup

" Always use Unix plaintext EOL defaults, regardless of platform
set fileformats=unix,dos

" Column to wrap text at
set textwidth=80

" When adding a newline & no indenting is specified by the filetype, keep the
" same indent as the previous line. Generally useful behaviour.
set autoindent

" Expand tabs out to spaces
set expandtab

" Set how many columns a tab counts for
set tabstop=4

" Set number of spaces to use for each (auto)indent
set shiftwidth=4

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Enable mouse in all modes
set mouse=a

" Enable modeline (disabled by default because it's a common source of vulns)
set modeline

" Look for fold markers by default (don't need to rely on modeline being set)
set foldmethod=marker

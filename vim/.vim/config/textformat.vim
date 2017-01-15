" t: Auto-wrap text to textwidth.
" c: Auto-wrap comments to textwidth & insert comment leader.
set formatoptions+=tc

" When making a new line & no indenting is specified by the filetype,
" keep the same indent as the previous line. Useful for READMEs &
" generally preferred behaviour.
set autoindent

" Expand tabs out to spaces
set expandtab

" Set how many columns a tab counts for
set tabstop=4

" Set number of spaces to use for each (auto)indent
set shiftwidth=4

" Set wrap width
set textwidth=80

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

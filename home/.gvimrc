" Set columns to 79 + columns the line numbers take up
" This adheres to the Python PEP 8 style guide, which suggests lines to be not
" more than 79 characters long
let &columns=79+&numberwidth

" Source extra commands depending on OS
if has('win32')
    " Set fonts (not fontconfig, bit weird)
    set guifont=Terminus:h14
    set guifontwide=MS_Gothic:h11
elseif has('unix')
    " Set main font
    set guifont=Terminus\ 10
endif

" Colour the column which you shall not pass (!)
" By default, it is a slightly lighter shade than the background (same shade as
" the cursorline below)
let &colorcolumn = &textwidth + 1

" Enable syntax highlighting
syntax on

" Set colourscheme to Zenburn
colorscheme zenburn

" Show extra whitespace at end of line
" Colour = Zenburn theme (slightly lighter than CursorLine colour)
highlight ExtraWhitespace ctermbg=239 guibg=#4e4e4e

" Match group thing
match ExtraWhitespace /\s\+\%#\@<!$/

" Highlight YAML frontmatter
let g:vim_markdown_frontmatter = 1

" Disable automatic vim-markdown folding (annoying)
let g:vim_markdown_folding_disabled = 1

" Display the cursor position (line & column no.) in the right of the
" status line
set ruler

" Display line numbers on the left
set number

" Highlight current line
set cursorline

" Always display the status line, even if only one window is displayed
set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of
" having to
" "press <Enter> to continue"
"set cmdheight=2

" Highlight searches
set hlsearch

" Don't (soft) wrap while in a word
set linebreak

" Use visual bell over audible 'beep' when doing something 'bad' (e.g.
" hitting Escape in normal mode)
set visualbell

" Clear visual bell terminal code (default is to flash screen) -- no
" beeps or flashes :)
set t_vb=

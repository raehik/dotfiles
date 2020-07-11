colorscheme nord

" Enable syntax highlighting
syntax on

" Set various appearance settings.
"   ruler: display cursor position (line & columns no.) in status line (right)
"   number: display line numbers in status line (left)
"   cursorline: highlight current line
"   hlsearch: highlight search matches
"   linebreak: don't (soft) wrap while in a word
set ruler number cursorline hlsearch linebreak

" Colour the column which you shall not pass (!)
" By default, it's the same colour that cursorline uses.
let &colorcolumn = &textwidth + 1

" Show extra whitespace at end of line
" Colour = Zenburn theme (slightly lighter than CursorLine colour)
highlight ExtraWhitespace ctermbg=239 guibg=#4e4e4e
match ExtraWhitespace /\s\+\%#\@<!$/

" Highlight YAML frontmatter
let g:vim_markdown_frontmatter = 1

" Disable automatic vim-markdown folding (annoying)
let g:vim_markdown_folding_disabled = 1

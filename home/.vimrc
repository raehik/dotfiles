" vim: set foldmethod=marker :
"
" Vim runtime configuration.
"

"" Operation {{{
""" General {{{
" Enable mouse in all modes
"set mouse=a

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
""" }}}

""" File encoding {{{
" Set which encoding Vim displays characters in (on the terminal)
set encoding=utf-8

" Set file encodings & order for Vim to check
set fileencodings=ucs-bom,utf-8,latin1,shift-jis

" Set UTF-8 as default encoding to write to new file
set fileencoding=utf-8

" Set file formats (ending characters) & order for Vim to check (+ first format
" is default for new files)
set fileformats=unix,dos

" Make sure new files are Unix format
set fileformat=unix
""" }}}

""" Formatting {{{
" t: Auto-wrap text to textwidth.
" c: Auto-wrap comments to textwidth & insert comment leader.
set formatoptions+=tc

" When making a new line & no identing is specified by the filetype,
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
set textwidth=72

" Colour the column which you shall not pass (!)
" By default, it is a slightly lighter shade than the background (same shade as
" the cursorline below)
let &colorcolumn = &textwidth + 1

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
""" }}}
"" }}}

"" Appearance {{{
" Enable syntax highlighting
syntax on

" Set colourscheme to Zenburn
colorscheme zenburn

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
"" }}}

"" Mappings {{{
" Unmap the dumb F1 help key
" Since we can't do :unmap <F1> for some reason, map it to no-op
nmap <F1> <nop>

" Toggle between 'paste' and 'nopaste' modes
set pastetoggle=<F11>

" Map <C-L> (redraw screen) to also turn off search highlighting until
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Keybind to show tagbar
"nmap <F8> :TagbarToggle<CR> 

" Easier keybind for char/word/line info (rather than g<C-g>)
nmap <F12> g<C-g>

" Keybind to render current file (assumed Markdown) to HTML & view it
nmap <C-P> :!markdown-render -o "<C-R>%"<CR><CR>

""" Mnemonic file jumping {{{
" Ctrl-Left = back
nmap <Esc>Od <C-O>
" Ctrl-Right = forward
nmap <Esc>Oc <C-I>
""" }}}

""" Markdown header inserts {{{
nmap <F1> VypVr=
nmap <F2> VypVr-
nmap <F3> 0i### <Esc>
nmap <F4> 0i#### <Esc>
""" }}}

""" Wrap + view modes - toggle hard/soft {{{
" Thanks ktohg, http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
" setlocal means changes are limited to current buffer
noremap <silent> <Leader>r :call ToggleWrap()<CR>
function ToggleWrap()
  if &textwidth != 0
    echo "soft wrap"
    "silent! nunmap <buffer> <Home>
    "silent! nunmap <buffer> <End>
    "silent! iunmap <buffer> <Home>
    "silent! iunmap <buffer> <End>
    setlocal textwidth=0
    setlocal colorcolumn=0
    nnoremap  <buffer> <silent> <Up>   gk
    nnoremap  <buffer> <silent> <Down> gj
    inoremap  <buffer> <silent> <Up>   <C-o>gk
    inoremap  <buffer> <silent> <Down> <C-o>gj
  else
    echo "hard wrap"
    setlocal wrap
    "noremap  <buffer> <silent> <Home> g<Home>
    "noremap  <buffer> <silent> <End>  g<End>
    "inoremap <buffer> <silent> <Home> <C-o>g<Home>
    "inoremap <buffer> <silent> <End>  <C-o>g<End>
    set textwidth=72
    let &colorcolumn = &textwidth + 1
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
  endif
endfunction
""" }}}
"" }}}

"" Filetype-specific options {{{
" Auto soft wrap mode for Markdown
"autocmd Filetype markdown call ToggleWrap()

" Markdown: don't wrap headers
autocmd Filetype markdown set comments+=n:--,n:==

" Ruby: indent = 2
au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2
"" }}}

"" Plugin options {{{
""" Preview {{{
" Use edited GitHub CSS for Markdown previews
let g:PreviewCSSPath=$HOME . '/.style.css'
""" }}}
"" }}}

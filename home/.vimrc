" vim: set foldmethod=marker :
"
" Vim runtime configuration.
"

"" Operation {{{
""" Vundle setup {{{
" Vundle requires filetype off (can turn back on later)
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Define plugins
" Note: for some reason, these must be enclosed in SINGLE QUOTES
" I have no idea why :/
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-dispatch'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'scrooloose/syntastic'

"Plugin 'chriskempson/base16-vim'
"Plugin 'sickill/vim-monokai'
"Plugin 'whatyouhide/vim-gotham'
"Plugin 'altercation/vim-colors-solarized'

" Run end Vundle stuff (required!)
" (maybe adds RTPs?)
call vundle#end()

" Reenable filetype
filetype indent plugin on
""" }}}

""" UltiSnips configuration {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
""" }}}

""" syntastic configuration {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
""" }}}

""" General {{{
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
""" }}}

""" File encoding {{{
" Set which encoding Vim displays characters in (on the terminal)
set encoding=utf-8

" Set file encodings & order for Vim to check
set fileencodings=ucs-bom,utf-8,shift-jis,latin1

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

" Show extra whitespace at end of line
" Colour = Zenburn theme (slightly lighter than CursorLine colour)
highlight ExtraWhitespace ctermbg=239 guibg=#4e4e4e

" Match group thing
match ExtraWhitespace /\s\+\%#\@<!$/

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

" Toggle NERD tree
nmap <F8> :NERDTreeToggle<CR>
imap <F8> <C-o><F8>

" Toggle tagbar
nmap <F9> :TagbarToggle<CR>
imap <F9> <C-o><F9>

" Easier keybind for char/word/line info (rather than g<C-g>)
nmap <F12> g<C-g>

" Render current file
"nmap <C-P> :Dispatch! markdown-render -o "%"<CR><CR>
nmap <C-P> :Dispatch! file-render "%"<CR>

" Copy to main X clipboard
vmap <C-Y> "+y

" Paste from main X clipboard
" - just use Ctrl+Alt+V!

" Toggle spellcheck
nmap <Leader>s :set spell!<CR>

" ROT13 the whole file
"   mz : set mark z at cursor position
"   gg : top of file
"   g? : applies ROT13 to a specified movement
"   G  : end of file (i.e. with previous 2 commands, applies ROT13 on all)
"   `z : go to mark z (original cursor position)
"
map <Leader># mzggg?G`z

""" Base mappings {{{
" Unmap the dumb F1 help key
" Since we can't do :unmap <F1> for some reason, map it to no-op
nmap <F1> <nop>

" Toggle between 'paste' and 'nopaste' modes
set pastetoggle=<F11>

" Map <C-L> (redraw screen) to also turn off search highlighting until
" next search
nnoremap <C-L> :nohl<CR><C-L>
""" }}}

""" Inserts {{{
" Insert current date
imap <C-D> <C-R>=strftime("%F")<CR>

" Insert current time
imap <C-T> <C-R>=strftime("%T")<CR>

" check mark ✓ check mark ✓ check mark ✓ must be check mark ✓
imap <C-C> ✓

" X mark
"imap <C-X> ✗
""" }}}

""" Markdown header inserts {{{
" Normal mode
nmap <F1> VypVr=
nmap <F2> VypVr-
nmap <F3> 0i### <Esc>
nmap <F4> 0i#### <Esc>

" Insert mode: insert some extra newlines as well, so I can keep writing
imap <F1> <Esc><F1>A
imap <F2> <Esc><F2>A
imap <F3> <Esc><F3>A
imap <F4> <Esc><F4>A
""" }}}
""" Mnemonic file jumping {{{
" Ctrl-Left = back
nmap <Esc>Od <C-O>
" Ctrl-Right = forward
nmap <Esc>Oc <C-I>
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
        set textwidth=80
        let &colorcolumn = &textwidth + 1
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
    endif
endfunction
""" }}}

""" remind functions {{{
" tick
nmap <Leader>c 0/MSG<CR>wi✓ <ESC>ZZ

" open file specified at end
"nmap <Leader>o $gf
""" }}}

"" Filetype-specific options {{{
" Auto soft wrap mode for Markdown
"autocmd Filetype markdown call ToggleWrap()

" Markdown: don't wrap headers
autocmd Filetype markdown set comments+=n:--,n:==

" Ruby: indent = 2
au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2
"" }}}

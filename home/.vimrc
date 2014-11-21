" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
"set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
"set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
"set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2


" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
" raehik's additions

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Make backups of files when saved (file name with ~ appended)
"set backup

" Don't
set nobackup

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Set colourscheme to Zenburn
colorscheme zenburn

" Set colourscheme to customised Zenburn
"colors zenburn-no-italic

" Set colourscheme to dark Solarized + make it work in terminal
"let g:solarized_termcolors=256
"set background=dark
"colorscheme solarized


" Read *.md files as Markdown formatted
au BufRead,BufNewFile *.md set filetype=markdown

" Use edited GitHub CSS for Markdown previews
let g:PreviewCSSPath=$HOME . '/.style.css'

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

" Enable modeline (disabled by default because it is a common source of
" vulnerabilities)
set modeline

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Display line numbers on the left
set number

" Expand tabs out to spaces
set expandtab

" Set how many columns a tab counts for
set tabstop=4

" Set number of spaces to use for each (auto)indent
set shiftwidth=4

" Set wrap width
set textwidth=72

" Auto-wrap
set formatoptions+=t

" Colour the column which you shall not pass (!)
" By default, it is a slightly lighter shade than the background (same shade as
" the cursorline below)
let &colorcolumn = &textwidth + 1

" Highlight current line
set cursorline

" In Ruby files, set indent to just 2
au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Enable mouse for all modes
"set mouse=a

" Leave mouse at default (disabled for normal console Vim)
set mouse=

" Keybind to show tagbar
nmap <F8> :TagbarToggle<CR> 

" Easier keybind for char/word/line info
nmap <F2> g<C-g>
imap <F2> <Esc>g<C-g>a

" Map preview.vim key myself
" (must have commented it out in plugin/preview.vim
"nmap <Leader>P :Preview<CR>

" Mnemonic file jumping
" Left = back
nmap <Esc>Od <C-O>
" Right = forward
nmap <Esc>Oc <C-I>

" Wikify keybind
nmap <Leader>w :!wikify <C-R>%<CR><CR>

" default syntax
"let g:vimwiki_list = [{'path': '~/vimwiki'}]

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
"set confirm

" Never start another comment on newline if currently in one
" is this a good or bad line? seems kinda awkward. pretty sure I could maybe
" just set formatoptions=
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"   Custom colours for colorcolumn (default is based on 'background' setting &
"   whether you are in GUI or non-GUI mode)
" Black
"highlight ColorColumn guibg=#2c2d27
" Light grey
"highlight ColorColumn guibg=#5D5D62

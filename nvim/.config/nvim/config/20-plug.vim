call plug#begin(stdpath('data') . '/plugged')

" note: make sure to use single quotes for plugins!

" Base
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'

" Small & handy
Plug 'vim-scripts/loremipsum'

" Syntax
Plug 'tpope/vim-liquid'
Plug 'b4b4r07/vim-hcl'
Plug 'cespare/vim-toml'

" Specific
Plug 'tpope/vim-fugitive'
Plug 'briancollins/vim-jst'
Plug 'zchee/vim-flatbuffers'

" Hefty
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" Disabled for a long time
"Plug 'scrooloose/syntastic'
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'

" Themes
"Plug 'chriskempson/base16-vim'
"Plug 'sickill/vim-monokai'
"Plug 'whatyouhide/vim-gotham'
"Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'

" Status line
Plug 'vim-airline/vim-airline'

call plug#end()

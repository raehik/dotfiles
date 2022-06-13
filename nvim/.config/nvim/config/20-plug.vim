" vim-plug install (2021-02-27):
"     $ sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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
Plug 'neovimhaskell/haskell-vim'
Plug 'vmchale/dhall-vim'

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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'liuchengxu/space-vim-theme'

" Status line
Plug 'vim-airline/vim-airline'

call plug#end()

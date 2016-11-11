" Vundle requires filetype off (can turn back on later)
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Define plugins
" Note: for some reason, these must be enclosed in SINGLE QUOTES
" I have no idea why :/
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips'
Config ultisnips
Plugin 'honza/vim-snippets'
"Plugin 'scrooloose/syntastic'
"Config syntastic
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/loremipsum'

"Plugin 'chriskempson/base16-vim'
"Plugin 'sickill/vim-monokai'
"Plugin 'whatyouhide/vim-gotham'
"Plugin 'altercation/vim-colors-solarized'

" Run end Vundle stuff (required!)
" (maybe adds RTPs?)
call vundle#end()

" Reenable filetype
filetype indent plugin on

" Vundle requires filetype off (can turn back on later)
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Define plugins
" Note: for some reason, these must be enclosed in SINGLE QUOTES
" I have no idea why :/

" Have Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Base
Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'

" Small & handy
Plugin 'vim-scripts/loremipsum'

" Syntax
Plugin 'tpope/vim-liquid'
Plugin 'b4b4r07/vim-hcl'

" Specific
Plugin 'tpope/vim-fugitive'

" Hefty
"Plugin 'SirVer/ultisnips'
"Config ultisnips
"Plugin 'honza/vim-snippets'

" Disabled for a long time
"Plugin 'scrooloose/syntastic'
"Config syntastic
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'

" Themes
"Plugin 'chriskempson/base16-vim'
"Plugin 'sickill/vim-monokai'
"Plugin 'whatyouhide/vim-gotham'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'arcticicestudio/nord-vim'

" Run end Vundle stuff (required!)
" (maybe adds RTPs?)
call vundle#end()

" Reenable filetype
filetype indent plugin on

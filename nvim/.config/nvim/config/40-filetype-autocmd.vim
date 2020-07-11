" Markdown: don't wrap headers
autocmd Filetype markdown set comments+=n:--,n:==

" LaTeX: always treat *.tex as ft=tex, not sometimes plaintex
autocmd BufNewFile,BufRead *.tex set filetype=tex

" Mustache: treat *.html.mustache as ft=html (not generic, TODO)
autocmd BufNewFile,BufRead *.html.mustache set filetype=html

" SQL: treat *.sql as ft=mysql
autocmd BufNewFile,BufRead *.sql set filetype=mysql

" Ruby: indent = 2
autocmd FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Go: use tabs
autocmd FileType go setlocal noexpandtab

" Auto soft wrap mode for Markdown
" Requires sourcing config/map-wrapmode.vim
"autocmd Filetype markdown call ToggleWrap()

" Auto-jump to last position in file upon open (thanks to ':help last-position-jump')
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

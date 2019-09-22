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

" Auto-jump to previous last position in file on open
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

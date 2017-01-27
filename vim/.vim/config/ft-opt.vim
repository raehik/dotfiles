" Markdown: don't wrap headers
autocmd Filetype markdown set comments+=n:--,n:==

" LaTeX: always treat *.tex as ft=tex, not sometimes plaintex
autocmd BufNewFile,BufRead *.tex set filetype=tex

" Mustache: treat *.html.mustache as ft=html (not generic, TODO)
autocmd BufNewFile,BufRead *.html.mustache set filetype=html

" Ruby: indent = 2
autocmd FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Auto soft wrap mode for Markdown
" Requires sourcing config/map-wrapmode.vim
"autocmd Filetype markdown call ToggleWrap()

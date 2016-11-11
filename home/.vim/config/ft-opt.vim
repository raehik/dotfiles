" Markdown: don't wrap headers
autocmd Filetype markdown set comments+=n:--,n:==

" LaTeX: always treat *.tex as ft=tex, not sometimes plaintex
autocmd BufNewFile,BufRead *.tex set filetype=tex

" Ruby: indent = 2
autocmd FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Auto soft wrap mode for Markdown
" Requires sourcing config/map-wrapmode.vim
"autocmd Filetype markdown call ToggleWrap()

" Markdown: treat .md as Markdown (rather than Modula 2)
" Most of the Vim versions I use don't need this, but a Vim 2013 7.4 on Windows
" read it as Modula 2, so better to be safe.
autocmd BufNewFile,BufRead *.md setf markdown


" Markdown: don't wrap headers
autocmd FileType markdown set comments+=n:--,n:==

" Ruby: indent = 2
autocmd FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Auto soft wrap mode for Markdown
" Requires sourcing config/map-wrapmode.vim
"autocmd Filetype markdown call ToggleWrap()

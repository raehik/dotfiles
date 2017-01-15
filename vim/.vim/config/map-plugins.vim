" Toggle NERD tree
nmap <F8> :NERDTreeToggle<CR>
imap <F8> <C-o><F8>

" Toggle tagbar
nmap <F9> :TagbarToggle<CR>
imap <F9> <C-o><F9>

" Render current file
" Requires raehik/scripts (file-render script)
nmap <C-P> :Dispatch! file-render "%"<CR>

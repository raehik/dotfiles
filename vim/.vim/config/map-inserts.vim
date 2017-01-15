" Insert current date
imap <C-D> <C-R>=strftime("%F")<CR>

" Insert current time
imap <C-T> <C-R>=strftime("%T")<CR>

"" Markdown header inserts {{{
" Normal mode
nmap <F1> VypVr=
nmap <F2> VypVr-
nmap <F3> 0i### <Esc>
nmap <F4> 0i#### <Esc>

" Insert mode
imap <F1> <Esc><F1>A
imap <F2> <Esc><F2>A
imap <F3> <Esc><F3>A
imap <F4> <Esc><F4>A
"" }}}

" check mark ✓ check mark ✓ check mark ✓ must be check mark ✓
imap <C-C> ✓

" X mark
"imap <C-X> ✗

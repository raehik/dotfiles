" Insert current date
imap <C-d> <C-r>=strftime("%F")<CR>

" Insert current ISO-8601 datetime (date, time, timezone)
imap <C-t> <C-r>=strftime("%FT%T%z")<CR>
" Note that the above does not insert a colon between the hours and minutes for
" the timezone (%z). Though this is valid for ISO 8601 and RFC 3339 (which is
" based on the ISO 8601 standard), some parsers do not implement the
" specification correctly. If you need the colon:
"imap <C-t> <C-r>=system("date -Iseconds")[:-2]<CR>

"" Markdown header inserts {{{
" Normal mode
"#nmap <F1> VypVr=
"nmap <F2> VypVr-
nmap <F1> 0i# <Esc>
nmap <F2> 0i## <Esc>
nmap <F3> 0i### <Esc>
nmap <F4> 0i#### <Esc>

" Insert mode
imap <F1> <Esc><F1>A
imap <F2> <Esc><F2>A
imap <F3> <Esc><F3>A
imap <F4> <Esc><F4>A
"" }}}

" check mark ✓ check mark ✓ check mark ✓ must be check mark ✓
imap <C-c> ✓

" X mark
"imap <C-x> ✗

" 2019-01-09: disable arrow key movement XD
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

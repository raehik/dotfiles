" Unmap the dumb F1 help key
" Since we can't do :unmap <F1> for some reason, map it to no-op
nmap <F1> <nop>

" Toggle between 'paste' and 'nopaste' modes
set pastetoggle=<F11>

" Easier keybind for char/word/line info (rather than g<C-g>)
nmap <F12> g<C-g>

" Map <C-L> (redraw screen) to also turn off search highlighting until
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Copy to main X clipboard
vmap <C-Y> "+y

" Paste from main X clipboard
" > Use your terminal. urxvt uses Ctrl-Alt-V to paste (Ctrl-Alt-C to copy).

" Toggle spellcheck
nmap <Leader>s :set spell!<CR>

" Easier back-tab (shift left) mapping
" (eh, just use <C-w> and retab)
"imap <S-Tab> <C-O><<

"" Mnemonic file jumping {{{
" Ctrl-Left = back
nmap <Esc>Od <C-O>

" Ctrl-Right = forward
nmap <Esc>Oc <C-I>
"" }}}

" ROT13 the whole file
"   mz : set mark z at cursor position
"   gg : top of file
"   g? : applies ROT13 to a specified movement
"   G  : end of file (i.e. with previous 2 commands, applies ROT13 on all)
"   `z : go to mark z (original cursor position)
"
map <Leader># mzggg?G`z

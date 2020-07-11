" Thanks ktohg, http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
" setlocal means changes are limited to current buffer
noremap <silent> <Leader>r :call ToggleWrap()<CR>
function ToggleWrap()
    if &textwidth != 0
        echo "soft wrap"
        "silent! nunmap <buffer> <Home>
        "silent! nunmap <buffer> <End>
        "silent! iunmap <buffer> <Home>
        "silent! iunmap <buffer> <End>
        setlocal textwidth=0
        setlocal colorcolumn=0
        nnoremap  <buffer> <silent> <Up>   gk
        nnoremap  <buffer> <silent> <Down> gj
        inoremap  <buffer> <silent> <Up>   <C-o>gk
        inoremap  <buffer> <silent> <Down> <C-o>gj
    else
        echo "hard wrap"
        setlocal wrap
        "noremap  <buffer> <silent> <Home> g<Home>
        "noremap  <buffer> <silent> <End>  g<End>
        "inoremap <buffer> <silent> <Home> <C-o>g<Home>
        "inoremap <buffer> <silent> <End>  <C-o>g<End>
        set textwidth=80
        let &colorcolumn = &textwidth + 1
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
    endif
endfunction

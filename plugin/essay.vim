let s:enabled = 0

function! ToggleEssayMode()
    if s:enabled
        unmap j
        unmap k
        let s:enabled = 0
    else
        nnoremap j gj
        nnoremap k gk
        let s:enabled = 1
    endif
endfunction

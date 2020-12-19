let s:enabled = 0

function! ToggleCenterMode()
    if s:enabled
        unmap j
        unmap k
	nmap <C-f> {
	nmap <C-d> }
        let s:enabled = 0
    else
	nmap <C-f> {zz
	nmap <C-d> }zz
        nnoremap j jzz
        nnoremap k kzz
        let s:enabled = 1
    endif
endfunction


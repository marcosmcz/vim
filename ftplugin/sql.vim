""""""""""""""""""""""""
"  Ftplugin open "
""""""""""""""""""""""""
"open ftphlugin
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/sql.vim<CR>
""""""""""""""""""""""""
"  Testing "
""""""""""""""""""""""""

" run Jest on current file
function! RSpecRun(commandType)
	let l:command = getline('.')
	call VimuxRunCommand(l:command . ';')
endfunction
nmap <leader>rt :w<CR>:call RSpecRun('')<CR>
" nmap <leader>rs :w<CR>:call RSpecRun('test_at_line')<CR>
nmap <Leader>ll :w<CR>:VimuxRunLastCommand<CR>

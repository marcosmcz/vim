" Commenting blocks of code.
noremap <silent> 00 :<C-B>silent <C-E>s/^/<C-R>=escape('//','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>
" 
"jsx comments
function! JsxComment()
	let l:start_line = line("'<")
	let l:end_line = line("'>")
	:'<,s/^/<C-R>=escape('{/*','\/')<CR>/<CR>
	:'>,s/^/<C-R>=escape('*/}','\/')<CR>/<CR>
	endif
	return diff
endfunction
map 55 <ESC>^i/*<ESC>$a*/<ESC>
map <leader>55 <ESC>^xx$xx
" map <leader>\\ <ESC>0i {/* <ESC>$a */}<ESC>
" map <silent> <leader>55 :<C-U>'<,s/^/<C-R>=escape('{/*','\/')<CR>/<CR><CR> :<C-U>'>,s/^/<C-R>=escape('*/}','\/')<CR>/<CR>:nohlsearch<CR>
" map <leader>55 :<C-U>:'<,s/^/<C-R>=escape('{/*','\/')<CR>/<CR>:'>,s/^/<C-R>=escape('*/}','\/')<CR>/<CR>:nohlsearch<CR>
" map <leader>55 :<C-U>JsxComment<CR>
"set tabs
setlocal ts=4 sts=4 sw=4

"use html snippets in js
UltiSnipsAddFiletypes html

"open ftphlugin
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/javascript.vim<CR>

"---------------------------------------------------------------------------------------------
"------------------------------------------------------Snippets----------------------------------
"---------------------------------------------------------------------------------------------
"open React.JS snippets file
nmap <leader>esr :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/javascript/javascript-react.snippets<CR>
"open js snippets file
nmap <leader>esj :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/javascript/javascript.snippets<CR>
"open html snippets file
nmap <leader>esh :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/html.snippets<CR>


"---------------------------------------------------------------------------------------------
"------------------------------------------------------Prettier----------------------------------
"---------------------------------------------------------------------------------------------
set formatprg=prettier\ --stdin

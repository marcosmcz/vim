"insert comments
noremap <buffer><silent> 44 :<C-B>silent <C-E>s/^/<C-R>=escape('" ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <buffer><silent> <Leader>44 :<C-B>silent <C-E>s/^\V<C-R>=escape('" ','\/')<CR>//e<CR>:nohlsearch<CR>

"insert comment
inoremap <buffer> // "<SPACE>

set ts=4 sw=4 sts=4

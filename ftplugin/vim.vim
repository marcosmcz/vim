"insert comments
noremap <silent> 00 :<C-B>silent <C-E>s/^/<C-R>=escape('" ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('" ','\/')<CR>//e<CR>:nohlsearch<CR>

"insert comment
inoremap <buffer> // "<SPACE>

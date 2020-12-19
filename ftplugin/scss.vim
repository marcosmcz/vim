setlocal ts=2 sts=2 sw=2

" Commenting blocks of code.
noremap <silent> 00 :<C-B>silent <C-E>s/^/<C-R>=escape('//','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>

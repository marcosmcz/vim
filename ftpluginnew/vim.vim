"insert comments
noremap <silent> ,00 :<C-B>silent <C-E>s/^/<C-R>=escape('" ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('" ','\/')<CR>//e<CR>:nohlsearch<CR>
" map <silent>00 ^@='I" <C-V><Esc>'<CR>
" map <silent><Leader>00 :s/" //<CR>:noh<CR>
" "add/remove comment for whole block
" vmap <silent>99 :s/^/" /<CR>:noh<CR>
" vmap <silent><Leader>99 :s/^" //<CR>:noh<CR>

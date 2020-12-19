" setl spell spelllang=en_gb
"open ftplugin file
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/tex.vim<CR>
" go to middle of line
map gm :call cursor(0, virtcol('$')/2)<CR>
"capitalize word under cursor
nmap <leader>cw b~w
"capitalize first word of sentence
" nmap cs :s/^./\u&/|norm!``<CR>:noh<CR>
nmap <silent> <leader>cs :s/^./\u&/\|norm!``<CR>:noh<CR>


"insert comments
noremap <silent> 00 :<C-B>silent <C-E>s/^/<C-R>=escape('% ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('% ','\/')<CR>//e<CR>:nohlsearch<CR>

"omnicompletion
imap ;o <C-x><C-o>

"---snippets-----
"open tex snippets file
nmap <leader>es :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/tex.snippets<CR>

"---word completions----
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"---Sweave files commands----
"insert comments
noremap <silent> 99 :<C-B>silent <C-E>s/^/<C-R>=escape('# ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,99 :<C-B>silent <C-E>s/^\V<C-R>=escape('# ','\/')<CR>//e<CR>:nohlsearch<CR>

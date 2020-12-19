"insert comments
noremap <silent> 00 :<C-B>silent <C-E>s/^/<C-R>=escape('% ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('% ','\/')<CR>//e<CR>:nohlsearch<CR>
"Spell check
setl spell spelllang=en_gb
"open ftplugin file
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/tex.vim<CR>

inoremap // %<SPACE>

" Remap navigation commands to center view on cursor using zz
nnoremap <leader>cm :call ToggleCenterMode()<cr>
"---word completions----
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
"omnicompletion
imap 'o <C-x><C-o>

"---snippets-----
"open tex snippets file
nmap <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/snippets/tex.snippets<CR>

"autocompile pdf
nmap <leader>cc :! pdflatex main.tex<CR>

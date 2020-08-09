"insert comments
map <silent>00 ^@='I% <C-V><Esc>'<CR>
map <silent><Leader>00 :s/% //<CR>:noh<CR>
"add/remove comment for whole block
vmap <silent>99 :s/^/% /<CR>:noh<CR>
vmap <silent><Leader>99 :s/^% //<CR>:noh<CR>
"Spell check
setl spell spelllang=en_gb
"open ftplugin file
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/tex.vim<CR>


"omnicompletion
imap 'o <C-x><C-o>

"---snippets-----
"open tex snippets file
nmap <leader>es :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/tex.snippets<CR>


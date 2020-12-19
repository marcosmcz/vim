"navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

"---------------------------------------------------------------------------------------------
"
"insert comments
map <silent>00 ^@='I# <C-V><Esc>'<CR>
map <silent><Leader>00 :s/# //<CR>:noh<CR>
"add/remove comment for whole block
vmap <silent>99 :s/^/# /<CR>:noh<CR>
vmap <silent><Leader>99 :s/^# //<CR>:noh<CR>

"Spell check
setl spell spelllang=en_gb

"open ftplugin file
nmap <leader>ef :tabnew /home/cos/.config/nvim/ftplugin/r.vim<CR>

"omnicompletion
imap 'o <C-x><C-o>

"---snippets-----
"open tex snippets file
nmap <leader>es :tabnew /home/cos/.config/nvim/plugged/vim-snippets/snippets/r.snippets<CR>


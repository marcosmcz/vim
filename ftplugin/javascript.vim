"add/remove comment for one line
map <silent>00 ^@='I// <C-V><Esc>'<CR>
map <silent><Leader>00 :s/// //<CR>:noh<CR>
"add/remove comment for whole block
vmap <silent>99 :s/^/// /<CR>:noh<CR>
vmap <silent><Leader>99 :s/^// //<CR>:noh<CR>

"set tabs
setlocal ts=4 sts=4 sw=4

"use html snippets in js
UltiSnipsAddFiletypes html

"open ftphlugin
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/javascript.vim<CR>

"---------------------------------------------------------------------------------------------
"------------------------------------------------------Snippets----------------------------------
"---------------------------------------------------------------------------------------------
"open react js snippets file
nmap <leader>esr :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/javascript/javascript-react.snippets<CR>
"open js snippets file
nmap <leader>esj :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/javascript/javascript.snippets<CR>
"open html snippets file
nmap <leader>esh :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/html.snippets<CR>


"insert comments
map <silent>00 ^@='I" <C-V><Esc>'<CR>
map <silent><Leader>00 :s/" //<CR>:noh<CR>
"add/remove comment for whole block
vmap <silent>99 :s/^/" /<CR>:noh<CR>
vmap <silent><Leader>99 :s/^" //<CR>:noh<CR>

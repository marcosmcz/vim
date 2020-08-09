let g:ale_linters = {
		\   'ruby': ['standardrb', 'rubocop'],
      \}
let g:ale_fixers = {
      \    'ruby': ['standardrb'],
      \}
let g:ale_fix_on_save = 1


"insert comments
map <silent>00 ^@='I# <C-V><Esc>'<CR>
map <silent><Leader>00 :s/# //<CR>:noh<CR>
"add/remove comment for whole block
vmap <silent>99 :s/^/# /<CR>:noh<CR>
vmap <silent><Leader>99 :s/^# //<CR>:noh<CR>

"open ftplugin file
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/ruby.vim<CR>

"omnicompletion
imap 'o <C-x><C-o>

"---snippets-----
"open ruby snippets file
nmap <leader>esb :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/ruby.snippets<CR>
"open rails snippets file
nmap <leader>esl :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/rails.snippets<CR>
"open erb snippets file
nmap <leader>ese :tabnew /home/cos/.vim/plugged/vim-snippets/UltiSnips/html.snippets<CR>


"---------------------------------------------------------------------------------------------
"------------------------------------------------------vimux----------------------------------
"---------------------------------------------------------------------------------------------
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
"Run last command executed by VimuxRunCommand
map <Leader>ll :VimuxRunLastCommand<CR><bar><C-w>j
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>2<C-w>j
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

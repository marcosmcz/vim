"add/remove comment for one line
map <silent>00 ^@='I# <C-V><Esc>'<CR>
map <silent><Leader>00 :s/# //<CR>:noh<CR>
"add/remove comment for whole block
vmap <silent>99 :s/^/# /<CR>:noh<CR>
vmap <silent><Leader>99 :s/^# //<CR>:noh<CR>
"adds colon after functions
inoremap ;; <right>:<CR>

"diable popup window
set completeopt-=preview

"open ftplugin
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/python.vim<CR>


"---------------------------------------------------------------------------------------------
"------------------------------------------------------Pymode----------------------------------
"---------------------------------------------------------------------------------------------
nnoremap <Tab><Tab> :PymodeLintAuto<CR>


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

"---------------------------------------------------------------------------------------------
"------------------------------------------------------Snippets----------------------------------
"---------------------------------------------------------------------------------------------
"open tex snippets file
nmap <leader>es :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/python.snippets<CR>


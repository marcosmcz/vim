" Commenting blocks of code.
noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('#','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>
"
"guide lines
nmap <leader>cl :set cursorcolumn!<Bar>set cursorline!<CR>

"insert comment
inoremap // #<SPACE>

let s:comment_map = {
    \   "python": '#'
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " "
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction


nnoremap <buffer> <silent> 00 :call ToggleComment()<cr>
vnoremap <buffer> <silent> 00 :call ToggleComment()<cr>

"diable popup window
set completeopt-=preview

"indentation
set ts=8 et sw=4 sts=4
set autoindent

"folding"
" setlocal foldmethod=indent
" set foldnestmax=1
"---word completions----
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"open ftplugin
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/python.vim<CR>


"---------------------------------------------------------------------------------------------
"------------------------------------------------------Pymode----------------------------------
"---------------------------------------------------------------------------------------------


"---------------------------------------------------------------------------------------------
"------------------------------------------------------vimux----------------------------------
"---------------------------------------------------------------------------------------------
" Prompt to run current file
map <Leader>vp :VimuxPromptCommand<CR>python3 <C-R>=expand("%:t")<CR><CR>
"Run last command executed by VimuxRunCommand
map <Leader>ll :VimuxRunLastCommand<CR><bar><C-w>j
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>2<C-w>j
" Zoom the tmux runner pane
map <Leader>vv :VimuxZoomRunner<CR>

"---------------------------------------------------------------------------------------------
"------------------------------------------------------Snippets----------------------------------
"---------------------------------------------------------------------------------------------
"open python snippets file
nmap <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/snippets/python.snippets<CR>


" Commenting blocks of code.
 noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('//','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>

let s:comment_map = {
    \   "ruby": '#'
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


"open ftplugin file
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/ruby.vim<CR>

"omnicompletion
imap 'o <C-x><C-o>

"---word completions----
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"---snippets-----
"open ruby snippets file
nmap <leader>esb :tabnew $HOME/.vim/plugged/vim-snippets/snippets/ruby.snippets<CR>
"open rails snippets file
nmap <leader>esl :tabnew $HOME/.vim/plugged/vim-snippets/snippets/rails.snippets<CR>
"open erb snippets file
nmap <leader>ese :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/html.snippets<CR>


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

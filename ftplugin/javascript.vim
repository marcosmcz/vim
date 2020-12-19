" Commenting blocks of code.
 noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('//','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>

let s:comment_map = {
    \   "javascript": '\/\/'
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

"insert debugger statement
let s:debugging_map = {
    \   "javascript": 'debugger;'
    \ }

function! ToggleDebugging()
    if has_key(s:comment_map, &filetype)
        let debugging_leader = s:debugging_map[&filetype]
        if getline('.') =~ "^\\s*" . debugging_leader . " "
            " remove debugger from the line and delete that empty line
            execute "silent s/^\\(\\s*\\)" . debugging_leader . " /\\1/"
	    execute "normal dd"
        else
            if getline('.') =~ "^\\s*" . debugging_leader
                " remove the debugger from the line
                execute "silent s/^\\(\\s*\\)" . debugging_leader . "/\\1/"
            else
                " add debug to line above current line
		execute "normal O"
                execute " silent s/^\\(\\s*\\)/\\1" . debugging_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction


nnoremap <buffer> <silent> <leader>b :call ToggleDebugging()<cr>
vnoremap <buffer> <silent> <leader>b :call ToggleDebugging()<cr>

"set tabs
setlocal ts=2 sts=2 sw=2

" "insert debugger statement
" noremap <buffer> <silent> db :<C-B>silent <C-E>s/^/<C-R>=escape('debugger;','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> <leader>db  :<C-B>silent <C-E>s/^\V<C-R>=escape('debugger;','\/')<CR>//e<CR>:nohlsearch<CR>

"set folding
autocmd! BufReadPost * :if line('$') > 50 | set foldmethod=indent | endif
" if line('$') > 50
"    set foldmethod=indent
" endif
" set foldlevelstart = 0
" set foldnestmax=2
" let javaScript_fold=1 

"omnicompletion
"set omnifunc=javascriptcomplete#CompleteJS
imap ;o <C-x><C-o>
"---word completions----
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

" Remap navigation commands to center view on cursor using zz
nnoremap <leader>cm :call ToggleCenterMode()<cr>

"use html snippets in js
" UltiSnipsAddFiletypes html
"load ember js
UltiSnipsAddFiletypes javascript-ember

"open ftphlugin
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/javascript.vim<CR>

"---------------------------------------------------------------------------------------------
"------------------------------------------------------Snippets----------------------------------
"---------------------------------------------------------------------------------------------
"open react js snippets file
" nmap <leader>esr :tabnew $HOME/.vim/plugged/vim-snippets/snippets/javascript/javascript-react.snippets<CR>
"open js snippets file
nmap <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/snippets/javascript/javascript.snippets<CR>
"open html snippets file
" nmap <leader>esh :tabnew $HOME/.vim/plugged/vim-snippets/snippets/html.snippets<CR>
"open js ember snippts file
nmap <leader>ese :tabnew $HOME/.vim/plugged/vim-snippets/snippets/javascript/javascript-ember.snippets<CR>


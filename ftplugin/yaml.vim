autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
"insert comment
inoremap // #<SPACE>
noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('#','\/')<CR>/<CR>:nohlsearch<CR>


set foldmethod=manual
let s:comment_map = {
    \   "yaml": '#',
    \ }

function! ToggleCommentYaml()
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


nnoremap <buffer> <silent> 44 :call ToggleCommentYaml()<cr>
vnoremap <buffer> <silent> 44 :call ToggleCommentYaml()<cr>
""""""""""""""""""""""""
"  Miscelaneous "
""""""""""""""""""""""""
"open ftplugin file
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/yaml.vim<CR>

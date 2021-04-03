" setl spell spelllang=en_gb
"open ftplugin file
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/tex.vim<CR>
" go to middle of line
map gm :call cursor(0, virtcol('$')/2)<CR>
"capitalize word under cursor
nmap <leader>cw b~w
"capitalize first word of sentence
" nmap cs :s/^./\u&/|norm!``<CR>:noh<CR>
nmap <silent> <leader>cs :s/^./\u&/\|norm!``<CR>:noh<CR>

inoremap // %<SPACE>
inoremap crd Crowdmark<SPACE>

"insert comments
noremap <buffer><silent> <leader>44 :<C-B>silent <C-E>s/^/<C-R>=escape('% ','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer><silent> <>88 :<C-B>silent <C-E>s/^\V<C-R>=escape('% ','\/')<CR>//e<CR>:nohlsearch<CR>


let s:comment_map = {
    \   "tex": '%'
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
nnoremap <buffer> <silent> 44 :call ToggleComment()<cr>
vnoremap <buffer> <silent> 44 :call ToggleComment()<cr>

"---snippets-----
"open tex snippets file
nmap <leader>es :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/tex.snippets<CR>

"---word completions----
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"---Sweave files commands----
"insert comments
noremap <silent> 99 :<C-B>silent <C-E>s/^/<C-R>=escape('# ','\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,99 :<C-B>silent <C-E>s/^\V<C-R>=escape('# ','\/')<CR>//e<CR>:nohlsearch<CR>

"item indenting
call vimtex#imaps#add_map({
      \ 'lhs' : '<m-i>',
      \ 'rhs' : '\item ',
      \ 'leader'  : '',
      \ 'wrapper' : 'vimtex#imaps#wrap_environment',
      \ 'context' : [
      \   'itemize',
      \   'enumerate',
      \   {'envs' : ['description'], 'rhs' : '\item['},
      \ ],
      \})


"insert/remove dollar signs
nnoremap <buffer><Leader>w$ ciw$<C-R><C-O>"$<ESC> 
xnoremap <buffer><leader>w$ xi$$<Esc>P

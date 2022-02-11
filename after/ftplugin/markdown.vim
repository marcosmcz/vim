""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
let StartComment="<!---" | let EndComment="-->"
function! Commenting()
     try
         execute ":s@^".g:StartComment." @\@g"
         execute ":s@ ".g:EndComment."$@@g"
     catch
        execute ":s/^/".g:StartComment." /g"
        execute ":s/$/ ".g:EndComment."/g"
     endtry
endfunction

noremap <buffer> <silent>44 :call Commenting()<CR>

" comment everything
function! UnversalCommenting()
        execute ":s/^/".g:StartComment." /g"
        execute ":s/$/ ".g:EndComment."/g"
endfunction
 
noremap <buffer> <silent> <Leader>44 :call UnversalCommenting()<CR>

""""""""""""""""""""""""
"  preview markdown "
""""""""""""""""""""""""
nmap <buffer> <Leader>ll :MarkdownPreview<CR>

""""""""""""""""""""""""
"  Compile to pdf "
""""""""""""""""""""""""
" use tex snippets
" UltiSnipsAddFiletypes tex 
"compile markdown to pdf
nnoremap <buffer> <Leader>cl :w<CR>:! pandoc -o %:r.pdf % <CR>

""""""""""""""""""""""""
"  Open ftplugin "
""""""""""""""""""""""""
nmap <leader>ef :tabnew $HOME/.vim/after/ftplugin/markdown.vim<CR>

""""""""""""""""""""""""
"  snippets "
""""""""""""""""""""""""
"open markdown snippets file
nmap <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/snippets/markdown.snippets<CR>
nmap <leader>esu :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/markdown.snippets<CR>

""""""""""""""""""""""""
"  Writing "
""""""""""""""""""""""""
set completeopt-=preview
"omnicompletion
imap ,o <C-x><C-o>
"---word completions----
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <buffer> <expr> <Tab>
			\ UltiSnips#CanExpandSnippet() ? "\<C-R>=UltiSnips#ExpandSnippet()<CR>" :
			\ pumvisible() ? "\<C-y>" :
			\ "\<C-n>"

" indent
" set autoindent
" filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
let g:vim_markdown_new_list_item_indent = 0

"insert comment
inoremap <buffer> // <!---<CR><CR>--><ESC>ki

inoremap ' '



""""""""""""""""""""""""
"  ExtraWhitespace "
""""""""""""""""""""""""
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\s\+\%#\@<!$/
" augroup BadStuff
" 	autocmd!
" 	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" 	autocmd BufWinLeave * call clearmatches()
" augroup END


let g:airline#extensions#wordcount#enabled = 1

""""""""""""""""""""""""
"  todo list "
""""""""""""""""""""""""
" let b:simple_todo_map_keys = 0
" nmap <Leader>i <Plug>(simple-todo-new)
" nmap <LocalLeader><LocalLeader> <Plug>(simple-todo-mark-switch)
" nmap <LocalLeader>o <Plug>(simple-todo-below)

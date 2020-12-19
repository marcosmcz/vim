"prevent markdown files from precoessing html settings
if &ft=="markdown"
  finish
endif
set tabstop     =2
set softtabstop =2
set shiftwidth  =4
set expandtab

"open ftphlugin
nmap <buffer> <leader>ef :tabnew $HOME/.vim/ftplugin/html.vim<CR>

"commenting
let StartComment="{{!--" | let EndComment="--}}"
function! Commenting()
"     try
"         execute ":s@^".g:StartComment." @\@g"
"         execute ":s@ ".g:EndComment."$@@g"
"     catch
        execute ":s/^/".g:StartComment." /g"
        execute ":s/$/ ".g:EndComment."/g"
"     endtry
endfunction

noremap <buffer> <silent>00 :call Commenting()<CR>

function! Uncommenting()
        execute ":s/^".g:StartComment."//g"
        execute ":s/".g:EndComment."//g"
endfunction
" 
noremap <buffer> <silent> ,00 :call Uncommenting()<CR>

"get handlebar snippets
UltiSnipsAddFiletypes handlebars
"open html snippets file
nmap <leader>esh :tabnew $HOME/.vim/plugged/vim-snippets/snippets/html.snippets<CR>
"open handlebars snippets file
nmap <leader>esr :tabnew $HOME/.vim/plugged/vim-snippets/snippets/handlebars.snippets<CR>


" function! Commenting()
" 	execute ":<C-B>silent <C-E>s/^/<C-R>=escape('{{!--','\/')<CR>/<CR>:nohlsearch<CR> <bar>'':<C-B>silent <C-E>s/$/<C-R>=escape(' --}}','\/')<CR>/<CR>:nohlsearch<CR>"
" endfunction
"commenting
" noremap <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('{{!--','\/')<CR>//e<CR>:nohlsearch<CR>:<C-B>silent <C-E>s/\V<C-R>=escape('--}}','\/')<CR>//e<CR>:nohlsearch<CR>


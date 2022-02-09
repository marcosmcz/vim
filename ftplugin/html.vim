"prevent markdown files from precoessing html settings
if &ft=="markdown"
  finish
endif
""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
autocmd FileType html set commentstring={{!--%s--}}
let StartComment="{{!--" | let EndComment="--}}"
function! Commenting()
     try
		 " uncomment
         execute ":s@^".g:StartComment." @\@g"
         execute ":s@ ".g:EndComment."$@@g"
     catch
		 " comment
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

" insert comment
inoremap <buffer> // {{!--   --}}<ESC>5hi

""""""""""""""""""""""""
"  Snippets "
""""""""""""""""""""""""
"get handlebar snippets
UltiSnipsAddFiletypes handlebars
"open html snippets file
nmap <leader>esh :tabnew $HOME/.vim/plugged/vim-snippets/snippets/html.snippets<CR>
"open handlebars snippets file
nmap <leader>esr :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/handlebars.snippets<CR>


""""""""""""""""""""""""
"  Debugging "
""""""""""""""""""""""""
let s:debug_map = {
    \   "html.handlebars": '{{ debugger }}'
    \ }

function! ToggleDebuggingHtml(lnum)
    if has_key(s:debug_map, &filetype)
        let debugging_leader = s:debug_map[&filetype]
        let line = getline(a:lnum)
        if strridx(line, debugging_leader) != -1
            " if line has debugger delete it
                normal mm
                normal dd
        else
            let plnum = prevnonblank(a:lnum)

            let indents = repeat(' ', indent(plnum))
            call append(line('.')-1, indents.debugging_leader)
            normal k
            exe "BookmarkAnnotate Debug"
        endif
    endif
endfunction

nnoremap <buffer> <silent> <leader>b :w<CR>:call ToggleDebuggingHtml(line('.'))<CR>
"guide lines
nmap <buffer> <silent><leader>cl :set cursorcolumn!<Bar>set cursorline!<CR>

""""""""""""""""""""""""
"  HTML style "
""""""""""""""""""""""""
setlocal tabstop     =2
setlocal softtabstop =2
setlocal shiftwidth  =2
setlocal expandtab

" auto wrap comments using textwidth only, inserting the current comment
" leader auotmatically
setlocal textwidth=65
au BufEnter * setlocal fo+=c fo-=r fo-=o

" going over 80 characters
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

highlight SignSearch ctermbg=blue ctermfg=17 guibg=#00005f
function! HighligtCurrentLineHTML()
    let l:m = join(filter(
       \ map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'),
       \ 'line("''".v:val) == line(".")'))
	normal mm
    if empty(l:m)
		normal ml
" 		let mline = line("'l")
		let mline = line(".")
		let command = matchadd("Search","\\%".mline."l")
		execute command
	else
        execute "delmarks" l:m
		call clearmatches()
    endif
endfunction
nnoremap mh :call HighligtCurrentLineHTML()<CR>

" highlight empty space
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
2match ExtraWhitespace /\s\+\%#\@<!$/

augroup BadStuff
	autocmd!
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
				\ | highlight SignSearch ctermbg=blue ctermfg=17 guibg=#00005f
	autocmd BufWinLeave * call clearmatches()
augroup END

""""""""""""""""""""""""
"  Misc "
""""""""""""""""""""""""
"open ftphlugin
nmap <buffer> <leader>ef :tabnew $HOME/.vim/ftplugin/html.vim<CR>

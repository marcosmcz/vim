""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
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

nnoremap <buffer> <silent> 44 :call ToggleComment()<cr>
vnoremap <buffer> <silent> 44 :call ToggleComment()<cr>

""""""""""""""""""""""""
"  Folding "
""""""""""""""""""""""""
"set folding
" autocmd! BufReadPost * :if line('$') > 50 | set foldmethod=indent | endif
" if line('$') > 50
"    set foldmethod=indent
" endif
" set foldlevelstart = 0
" set foldnestmax=2
" let javaScript_fold=1 


""""""""""""""""""""""""
"  JS style "
""""""""""""""""""""""""
"set tabs
setlocal ts=2 sts=2 sw=2
setlocal textwidth=65

" auto wrap comments using textwidth only, inserting the current comment
" leader auotmatically
au BufEnter * setlocal fo+=c fo+=r fo-=o

"line limit applies to all text
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
" highlight empty space
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/

" highlight Search ctermbg=blue ctermfg=17 guibg=#00005f

function! HighligtCurrentLine()
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
nnoremap mh :call HighligtCurrentLine()<CR>

augroup BadStuff
	autocmd!
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" 				\ | highlight Search ctermbg=blue ctermfg=17 guibg=#00005f
	autocmd BufWinLeave * call clearmatches()
augroup END

""""""""""""""""""""""""
"  Writing "
""""""""""""""""""""""""
"omnicompletion
"set omnifunc=javascriptcomplete#CompleteJS
imap ;o <C-x><C-o>
"---word completions----
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <buffer> <expr> <Tab>
			\ UltiSnips#CanExpandSnippet() ? "\<C-R>=UltiSnips#ExpandSnippet()<CR>" :
			\ pumvisible() ? "\<C-y>" :
			\ "\<C-n>"
" go to definition
nnoremap <Leader>gf gd

" Remap navigation commands to center view on cursor using zz
nnoremap <leader>cm :call ToggleCenterMode()<cr>
" spell check
nnoremap <silent> <buffer> <leader>sc :setlocal spell! spelllang=en_us<cr>

""""""""""""""""""""""""
"  Vimux "
""""""""""""""""""""""""

function! OriginalRunCommand(commandType)
	let l:simple_command = "node ".expand("%:p")
	if a:commandType == 'simple'
		let g:original_command = l:simple_command
	else
		call inputsave()
			let arguments = input('Insert args seperated by space: ')
			let g:original_command = l:simple_command . " data/" .getline(2)." ".arguments 
		call inputrestore()
		" could also modify this to take in user input
	endif
	call VimuxRunCommand(g:original_command)
endfunction

function! RunLastCommand()
	let l:pattern = 'import ipdb;ipdb.set_trace()'
	let l:simple_command = "node ".expand("%:p")
    if search(l:pattern,'nw') " if debugger in file
 		call VimuxRunCommand("q")
    endif
	if exists("g:original_command")
		call VimuxRunCommand(g:original_command)
	else
		call VimuxRunCommand(l:simple_command)
	endif
endfunction

nmap <buffer> <Leader>ll :w<CR>:call RunLastCommand()<CR>
" Inspect runner pane
" nmap <buffer><Leader>vi :VimuxInspectRunner<CR>2<C-w>j
" Zoom the tmux runner pane
" nmap <buffer><Leader>vv :VimuxZoomRunner<CR>

""""""""""""""""""""""""
"  Debugging "
""""""""""""""""""""""""
"insert debugger statement
let s:debug_map = {
    \   "javascript": 'debugger;'
    \ }

function! ToggleDebugging(lnum)
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

nnoremap <buffer> <silent> <leader>b :w<CR>:call ToggleDebugging(line('.'))<CR>

"guide lines
nmap <buffer> <silent><leader>cl :set cursorcolumn!<Bar>set cursorline!<CR>

" "insert debugger statement
" noremap <buffer> <silent> db :<C-B>silent <C-E>s/^/<C-R>=escape('debugger;','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> <leader>db  :<C-B>silent <C-E>s/^\V<C-R>=escape('debugger;','\/')<CR>//e<CR>:nohlsearch<CR>

""""""""""""""""""""""""
"  Snippets "
""""""""""""""""""""""""
UltiSnipsAddFiletypes javascript-ember
"open js snippets file
nmap <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/snippets/javascript/javascript.snippets<CR>
"open js ember snippts file
nmap <leader>ese :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/javascript-ember.snippets<CR>

""""""""""""""""""""""""
"  Misc "
""""""""""""""""""""""""
"open ftphlugin
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/javascript.vim<CR>


" nmap } :<C-u>call search('^\s*$\\|\%$', 'W')<CR>
""""""""""""""""""""""""
"  COC "
""""""""""""""""""""""""
" coc popup scrolling
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(0) : "\{"
nnoremap <nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\}"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Left>"

" jump to errors
nmap <silent> <Localleader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <Localleader>k <Plug>(coc-diagnostic-prev-error)

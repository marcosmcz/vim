""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('#','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>
"guide lines
nmap <buffer> <silent><leader>cl :set cursorcolumn!<Bar>set cursorline!<CR>
"insert comment
inoremap <buffer> // #<SPACE><SPACE>#<Left><Left>

"insert block comments (has white space at end)
nnoremap <Leader>cb o#/* Block Comment<CR>#<CR>#*/<ESC>kA 
inoremap ,cb #/* Block Comment<CR>#<CR>#*/<ESC>kA 

let s:comment_map = { "python": '#'}

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
"  Writing "
""""""""""""""""""""""""
"lame"
imap xx X
"folding"
" setlocal foldmethod=indent
" set foldnestmax=1
set foldmethod=marker
set foldmarker=#/*,#*/

"---word completions----
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <Tab>
			\ UltiSnips#CanExpandSnippet() ? "\<C-R>=UltiSnips#ExpandSnippet()<CR>" :
			\ pumvisible() ? "\<C-y>" :
			\ "\<C-n>"

""""""""""""""""""""""""
"  PEP Style "
""""""""""""""""""""""""
" PEP 8 style
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
nnoremap <silent><Leader>p :silent PymodeLintAuto<CR>:silent! %s/# \/\*/#\/*/<CR>:silent! %s/# \*\//#\*\/<CR>
cabbrev pl PymodeLint

" auto wrap comments using textwidth only, inserting the current comment
" leader auotmatically
au BufEnter * setlocal fo+=c fo+=r fo-=o

"line limit applies to all text
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
" highlight empty space
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" 2match ExtraWhitespace /\s\+\%#\@<!$/
augroup BadStuff
	autocmd!
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
				\ | highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	autocmd BufWinLeave * call clearmatches()
augroup END


" highlight Search ctermbg=blue ctermfg=17 guibg=#00005f

function! HighligtCurrentLine()
    let l:m = join(filter(
       \ map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'),
       \ 'line("''".v:val) == line(".")'))
" 	normal mm
    if empty(l:m)
		normal ml
" 		let mline = line("'l")
		let mline = line(".")
		call matchadd("Search","\\%".mline."l")
	else
        execute "delmarks" l:m
		call clearmatches()
    endif
endfunction
nnoremap mh :call HighligtCurrentLine()<CR>

""""""""""""""""""""""""
"  Basic Settings Style "
""""""""""""""""""""""""
"diable popup window
set completeopt-=preview
"open ftplugin
nmap <buffer> <leader>ef :tabnew $HOME/.vim/ftplugin/python.vim<CR>


""""""""""""""""""""""""
"  Vimux "
""""""""""""""""""""""""

function! OriginalRunCommand(commandType)
	let l:simple_command = "python3 ".expand("%:p")
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

function! PythonRunLastCommand()
	let l:pattern = 'import ipdb;ipdb.set_trace()'
	let l:simple_command = "python3 ".expand("%:p")
    if search(l:pattern,'nw') " if debugger in file
 		call VimuxRunCommand("q")
    endif
	if exists("g:original_command")
		call VimuxRunCommand(g:original_command)
	else
		call VimuxRunCommand(l:simple_command)
	endif
endfunction

" run algo on csv
" nmap <buffer><Leader>va :w<CR>:call OriginalRunCommand('')<CR>
" run algo on csv with args
" nmap <buffer><Leader>va :w<CR>:VimuxPromptCommand<CR><C-r>=call OriginalRunCommand('')<CR>
" nmap <buffer><Leader>va :w<CR>:call VimuxRunCommand("<C-R>=OriginalRunCommand('')<CR>")<Left><Left>
" Prompt to run current file
nmap <buffer><Leader>vr :w<CR>:call OriginalRunCommand('simple')<CR>
" nmap <Leader>vb :w<CR>:VimuxPromptCommand<CR>python3 /vagrant/lib/plagiarism_detector/<C-R>=expand("%:t")<CR><CR>

"Run last command executed by VimuxRunCommand
" nmap <Leader>ll :w<CR>:PythonRunLastCommand<CR>
nmap <buffer> <Leader>ll :w<CR>:call PythonRunLastCommand()<CR>
" Inspect runner pane
nmap <buffer><Leader>vi :VimuxInspectRunner<CR>2<C-w>j
" Zoom the tmux runner pane
nmap <buffer><Leader>vv :VimuxZoomRunner<CR>

""""""""""""""""""""""""
"  Snippets "
""""""""""""""""""""""""
"open python snippets file
nmap <buffer> <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/python.snippets<CR>

""""""""""""""""""""""""
"  Debugging "
""""""""""""""""""""""""
"insert debugger statement
let s:debug_map = {
    \   "python": 'import ipdb;ipdb.set_trace()'
    \ }

function! ToggleDebuggingPython(lnum)
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

nnoremap <buffer> <silent> <localleader>b :call ToggleDebuggingPython(line('.'))<CR>

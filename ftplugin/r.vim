""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
" "insert comments
" map <silent>00 ^@='I# <C-V><Esc>'<CR>
" map <silent><Leader>00 :s/# //<CR>:noh<CR>
" "add/remove comment for whole block
" vmap <silent>99 :s/^/# /<CR>:noh<CR>
" vmap <silent><Leader>99 :s/^# //<CR>:noh<CR>

noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('#','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('//','\/')<CR>//e<CR>:nohlsearch<CR>
"guide lines
nmap <buffer> <silent><leader>cl :set cursorcolumn!<Bar>set cursorline!<CR>
"insert comment
inoremap <buffer> // #<SPACE><SPACE>#<Left><Left>

"insert block comments (has white space at end)
nnoremap <Leader>cb o#/* Block Comment<CR>#<CR>#*/<ESC>kA 
inoremap ,cb #/* Block Comment<CR>#<CR>#*/<ESC>kA 

let s:comment_map = { "r": '#'}

function! ToggleCommentR()
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

nnoremap <buffer><silent> 44 :call ToggleCommentR()<cr>
vnoremap <buffer><silent> 44 :call ToggleCommentR()<cr>

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
"Spell check
setl spell spelllang=en_gb



"---word completions----
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"omnicompletion
imap 'o <C-x><C-o>

""""""""""""""""""""""""
"  PEP Style "
""""""""""""""""""""""""
" PEP 8 style
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

" auto wrap comments using textwidth only, inserting the current comment
" leader auotmatically
au BufEnter * setlocal fo+=c fo+=r fo-=o

"line limit applies to all text
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
" highlight empty space
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
2match ExtraWhitespace /\s\+\%#\@<!$/
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
" nmap <leader>ef :tabnew /home/cos/.config/nvim/ftplugin/r.vim<CR>
nmap <buffer> <leader>ef :tabnew $HOME/.vim/ftplugin/r.vim<CR>


""""""""""""""""""""""""
"  Vimux "
""""""""""""""""""""""""

function! OriginalRunCommand(commandType)
	let l:simple_command = "/usr/local/bin/Rscript ".expand("%:p")
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
" 	let l:pattern = 'import ipdb;ipdb.set_trace()'
"     if search(l:pattern,'nw') " if debugger in file
"  		call VimuxRunCommand("q")
"     endif
	call VimuxRunCommand(g:original_command)
endfunction

" Prompt to run current file
nmap <buffer><Leader>vr :w<CR>:call OriginalRunCommand('simple')<CR>

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
" nmap <leader>es :tabnew /home/cos/.config/nvim/plugged/vim-snippets/snippets/r.snippets<CR>
nmap <buffer> <leader>es :tabnew $HOME/.vim/plugged/vim-snippets/snippets/r.snippets<CR>


""""""""""""""""""""""""
"  Debugging "
""""""""""""""""""""""""
"insert debugger statement
let s:debug_map = {
    \   "r": 'import ipdb;ipdb.set_trace()'
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

nnoremap <buffer> <silent> <leader>b :call ToggleDebuggingPython(line('.'))<CR>

""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""
"insert comment
inoremap // #<SPACE>
noremap <buffer> <silent> <leader>00 :<C-B>silent <C-E>s/^/<C-R>=escape('#','\/')<CR>/<CR>:nohlsearch<CR>
" noremap <buffer> <silent> ,00 :<C-B>silent <C-E>s/^\V<C-R>=escape('#','\/')<CR>//e<CR>:nohlsearch<CR>


set foldmethod=manual
let s:comment_map = {
    \   "ruby": '#',
    \ }

function! ToggleCommentRuby()
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


nnoremap <buffer> <silent> 44 :call ToggleCommentRuby()<cr>
vnoremap <buffer> <silent> 44 :call ToggleCommentRuby()<cr>


""""""""""""""""""""""""
"  Writing "
""""""""""""""""""""""""
"---word completions----
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"match ruby blocks
runtime macros/matchit.vim

"guide lines
nmap <buffer> <silent><leader>cl :set cursorcolumn!<Bar>set cursorline!<CR>

""""""""""""""""""""""""
"  Snippets "
""""""""""""""""""""""""
"open ruby snippets file
nmap <leader>esb :tabnew $HOME/.vim/plugged/vim-snippets/snippets/ruby.snippets<CR>
"open rails snippets file$HOME
nmap <leader>esl :tabnew $HOME/.vim/plugged/vim-snippets/snippets/rails.snippets<CR>
"open erb snippets file
nmap <leader>ese :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/html.snippets<CR>


""""""""""""""""""""""""
"  Vimux "
""""""""""""""""""""""""
" run current ruby file
map <Leader>vp :VimuxPromptCommand<CR>ruby <C-R>=expand("%:t")<CR><CR>
" Prompt to run current rake file
function! RakeTask()
	"get the task from under cursor
	"go to task that is above cursor
	"set mark
	normal! ma
	/task
	normal! N
	normal! ww
	let task = expand('<cword>')
	"get the line numbers of namespace and task
	"go to first occurances of namespace and task
	normal! gg
	/namespace
	normal! ww
	let namespace = expand('<cword>')
" 	let vimux_cmd = 'cd <C-R>=expand("%:p:h")<CR> && rake '
	let rake_task = namespace.":".task
	"jump to mark a
	normal! `a
	delmarks a
" 	return rake_task
	let vagrant_dir = '/vagrant/lib/tasks/import_rakes'
	let g:rake_cmnd = "cd ".vagrant_dir." && rake ".rake_task
	return g:rake_cmnd
" 	call VimuxRunCommand(g:rake_cmnd)
endfunction
map <Leader>vk :w<CR>:call VimuxRunCommand("<C-R>=RakeTask()<CR>")

" function! RubyRunLastCommand()
" 	let l:pattern = 'byebug'
"     if search(l:pattern,'nw') " if debugger in file
" 		call VimuxRunCommand("q!")
"     endif
" 	call VimuxRunCommand(g:rake_cmnd)
" endfunction
" nmap <Leader>ll :w<CR>:call RubyRunLastCommand()<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>:VimuxZoomRunner<CR>
" Zoom the tmux runner pane (I used s instead of z since its on the home row.
" these are the precious momemnts of our lives)
map <Leader>vs :VimuxZoomRunner<CR>

" run Rspec on current file
function! RSpecRun(commandType)
	let l:full_path = expand("%:p")
	let l:base_path = "/Users/marcoscardenas/crowdmark-api/"
	let l:spec_path = substitute(l:full_path, l:base_path, "", "")
	if a:commandType == 'test_at_line'
		call inputsave()
			let test_line = input('Insert line of test: ')
			if test_line == ''
				let l:spec_command = "rspec ".l:spec_path.":".line(".")
			else
				let l:spec_command = "rspec ".l:spec_path.":".test_line
			endif
		call inputrestore()
	else
		let l:spec_command = "rspec ".l:spec_path
	endif
	call VimuxRunCommand(l:spec_command)
endfunction
nmap <leader>fr :call RSpecRun('')<CR>
nmap <leader>rs :call RSpecRun('test_at_line')<CR>
nmap <Leader>ll :w<CR>:VimuxRunLastCommand<CR>

""""""""""""""""""""""""
"  Debugging "
""""""""""""""""""""""""
"insert debugger statement
let s:debug_map = {
    \   "ruby": 'byebug'
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

nnoremap <buffer> <silent> <leader>b :call ToggleDebugging(line('.'))<cr>

""""""""""""""""""""""""
"  Style "
""""""""""""""""""""""""
" auto wrap comments using textwidth only, inserting the current comment
" leader auotmatically
au BufEnter * setlocal fo+=c fo+=r fo-=o

"line limit applies to all text
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
" highlight empty space
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
2match ExtraWhitespace /\s\+\%#\@<!$/
augroup BadStuff
	autocmd!
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" 				\ | highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	autocmd BufWinLeave * call clearmatches()
augroup END

""""""""""""""""""""""""
"  Miscelaneous "
""""""""""""""""""""""""
"open ftplugin file
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/ruby.vim<CR>
" highlight SearchCurrent ctermfg=0 ctermbg=12 guifg=#000000 guibg=#005fff

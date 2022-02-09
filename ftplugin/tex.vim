""""""""""""""""""""""""
"  Commenting "
""""""""""""""""""""""""

let s:comment_map = {"tex": '%'}
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

"""""""""""""""""""""""""
"  Miscelaneous "
""""""""""""""""""""""""
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/tex.vim<CR>
"autocompile pdf
" nmap <leader>cc :! pdflatex main.tex<CR>
" open main.tex
nmap <leader>em :tabnew main.tex<CR>
" ctags shit
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
nnoremap K i<CR><ESC>

""""""""""""""""""""""""
"  Writing "
""""""""""""""""""""""""
setl spell spelllang=en_gb
inoremap // %<SPACE>
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
" italicisize word under cursor or in visual mode
nnoremap <LocalLeader>it ciw\textit{<C-R><C-O>"}<ESC>
xnoremap <LocalLeader>it xi\textit{}<Esc>P
" bold face word under cursor or in visual mode
nnoremap <LocalLeader>bf ciw\textbf{<C-R><C-O>"}<ESC>
xnoremap <LocalLeader>bf xi\textbf{}<Esc>P
" unmap vimtex mappings that interfere with t

""""""""""""""""""""""""
"  Snippets "
""""""""""""""""""""""""
"open tex snippets file
nmap <leader>ess :tabnew $HOME/.vim/plugged/vim-snippets/snippets/tex.snippets<CR>
nmap <leader>esu :tabnew $HOME/.vim/plugged/vim-snippets/UltiSnips/tex.snippets<CR>

""""""""""""""""""""""""
"  Style and Editor Aesthetic"
""""""""""""""""""""""""
" note: no indents are set in after/indent/tex.vim
" set laststatus=0
set indentexpr=
set textwidth=92

" Highlight characters that go over 92 characters limit on a line
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>92v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

nnoremap <Leader>th :call<SID>LongLineHLToggle()<cr>

" Remove unused whitespaces
fun! LatexTrimWhitespaces()
	let cursor_pos = getpos('.')
	silent! %s/\s\+$//e
	call setpos('.', cursor_pos)
endfunction

au BufWritePre <buffer> call LatexTrimWhitespaces()

" hide everything.
" let s:hidden_all = 0
" exe 'sign define piet text=-'
" exe 'sign define insert text=>>'
" function! ToggleHiddenAll()
"     if s:hidden_all  == 0
"         let s:hidden_all = 1
" ""         set noshowmode
"         set noruler
"         set laststatus=0
" ""         set noshowcmd
" "" 		set nonumber norelativenumber
" 		set showtabline=0
" "" 		au InsertLeave * set cursorline
" "" 		au InsertEnter * set nocursorline
" 		exe 'sign place 2 line=1 name=piet' 
" 		au BufEnter * exe 'sign place 2 line=1 name=piet' 
" 		au BufLeave * exe 'sign unplace 2' 
" 
"     else
"         let s:hidden_all = 0
" ""         set showmode
"         set ruler
"         set laststatus=2
" ""         set showcmd
" "" 		set number relativenumber
" 		set showtabline=2
" "" 		au InsertLeave * set nocursorline
" "" 		au InsertEnter * set nocursorline
" 		au BufEnter * exe 'sign unplace 2' 
" 		au BufLeave * exe 'sign unplace 2' 
" 		exe 'sign unplace 2'
"     endif
" endfunction
" nnoremap <silent> <LocalLeader>th :call ToggleHiddenAll()<CR>
" nnoremap <silent> <LocalLeader>tn :execute 'set number! relativenumber!'<CR>

" function! GetLine()
"   let start_line = line(".")
"   call inputsave()
"   let lines_below = input('Insert lines: ')
"   call inputrestore()
"   if lines_below == 'e'
"       let lines_until_end = line('$') - start_line
"       return lines_until_end
"   else
"     return lines_below
"   endif
" endfunction

" textbooks vars: my vars
function! Refactor()
let dict = {'C':'G','D': 'T',	'G':'A',	'I':'F',	'S':'E',	'L':'L',	'H':'I',	'J':'D'}
  let ref = 's/\C\<\%(' . join(keys(dict),'\|'). '\)\>/\='.string(dict).'[submatch(0)]/ge'
  return ref
endfunction

nnoremap <Leader>tr :.,+<C-R>=GetLine()<CR><C-R>=Refactor()<CR>

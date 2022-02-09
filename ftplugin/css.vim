""""""""""""""""""""""""
"  Commenting "
let StartComment="\\/\\*" | let EndComment="\\*\\/"

function! CSSCommenting()
	if getline('.') =~ "^\\s*" . g:StartComment . " "
		" Uncomment the line
		execute "silent s/^\\(\\s*\\)" . g:StartComment . " /\\1/"
		execute "silent s@ " . g:EndComment . "$@@g"
	else
		if getline('.') =~ "^\\s*" . g:StartComment
			" Uncomment the line
			execute "silent s/^\\(\\s*\\)" . g:StartComment . " /\\1/"
			execute "silent s@ " . g:EndComment . "$@@g"
		else
			" Comment the line
			execute "silent s/^\\(\\s*\\)/\\1" . g:StartComment . " /"
			execute "silent s/$/ " . g:EndComment . "/g"
		end
	end
endfunction

noremap <buffer> <silent> 44 :call CSSCommenting()<CR>

" insert comment
inoremap <buffer> // /*   */<ESC>3hi


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
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

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
				\ | highlight OverLength ctermbg=red ctermfg=white guibg=#592929
				\ | highlight SignSearch ctermbg=blue ctermfg=17 guibg=#00005f
	autocmd BufWinLeave * call clearmatches()
augroup END

""""""""""""""""""""""""
"  Misc "
""""""""""""""""""""""""
"open ftplugin
nmap <buffer> <leader>ef :tabnew $HOME/.vim/ftplugin/css.vim<CR>

"preview markdown
nmap <leader>mp :MarkdownPreview<CR>

"open ftplugin file
nmap <leader>ef :tabnew /home/cos/.vim/ftplugin/markdown.vim<CR>

"---snippets-----
"open tex snippets file
nmap <leader>es :tabnew /home/cos/.vim/plugged/vim-snippets/snippets/markdown.snippets<CR>


"---------------------------------------------------------------------------------------------
"------------------------------------------spell checking spelunker---------------------------
"---------------------------------------------------------------------------------------------
" Setting for g:spelunker_check_type = 1:
let g:spelunker_disable_auto_group = 1
augroup spelunker
	  autocmd!
	    autocmd BufWinEnter,BufWritePost *.tex,*.js,*.jsx,*.json,*.md call spelunker#check()
augroup END

"spell highlighting
hi SpellBad ctermfg=red guifg=red

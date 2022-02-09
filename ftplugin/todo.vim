nmap <LocalLeader><LocalLeader> :VimTodoListsToggleItem<CR>
"open ftplugin
nmap <leader>ef :tabnew $HOME/.vim/ftplugin/todo.vim<CR>

command! -range=% TodoSort call setline(<line1>, TodoSort(<line1>,<line2>))
fun! TodoSort(line1, line2)
  let line1 = a:line1

  let stack = [{ 'children': [], 'trailing': [] }]
  let out = []
  let previndent = 0
  let Match = { line -> matchlist(line, '^\s*- \[\(.\)\]\[\(.\),\(.\)\]') }

  fun! Compare(a, b) closure
    let a = Match(a:a.line)
    let b = Match(a:b.line)
    let a_importance = a[2]
    let a_difficulty = a[3]
    let b_importance = b[2]
    let b_difficulty = b[3]
	if a_importance == b_importance 
		if a_difficulty == b_difficulty 
			return 0
		elseif a_difficulty < b_difficulty 
			return -1
		elseif a_difficulty > b_difficulty 
			return 1
		endif
	elseif a_importance < b_importance 
		return 1
	elseif a_importance > b_importance 
		return -1
	endif
	endfun

  fun! Pop(n) closure
    return map(remove(stack, -a:n, -1), { _, e -> sort(e.children, 'Compare') })[0]
  endfun

  while empty(Match(getline(line1)))
    call add(out, getline(line1))
    let line1 += 1
  endwhile

  for lnum in range(line1, a:line2)
    let line = getline(lnum)
    if empty(Match(line))
      call add(stack[-1].children[-1].trailing, line)
      continue
    endif

    let indent = indent(lnum)
    if indent > previndent
      call add(stack, stack[-1].children[-1])
    elseif indent < previndent
      call Pop((previndent - indent) / shiftwidth())
    endif

    call add(stack[-1].children, {
          \ 'line': getline(lnum),
          \ 'lnum': lnum,
          \ 'children': [],
          \ 'trailing': [],
          \})
    let previndent = indent
  endfor

  fun! Flatten(lines, ...)
    let out = a:0 ? a:1 : []
    for line in a:lines
      call add(out, line.line)
      call extend(out, line.trailing)
      call Flatten(line.children, out)
    endfor
    return out
  endfun

  return Flatten(Pop(len(stack)), out)
endfun

" Notes
" For now, just create rows be sending the exact row format
" 
" Importance and Difficulty
" Goal: Do tasks that are High in Importance and Low in Difficulty
" Goal: Want [2,0], and not [0,2]
" Low,Medium,High = 0,1,2
" 
" [I,D]
" [2,1] high important and med diff
" [1,2] med imp and high diff
" [1,0] med imp and low diff
" [0,2] low imp and high diff
" 
" 
" Importance and Difficulty
" Goal: Do tasks that are High in Importance and Low in Difficulty
" Goal: Want [2,0], and not [0,2]
" Low,Medium,High = 0,1,2
" do a 0-9 scale (0 is low)
" 
" Goal 2, 4, 5 1, 3
" Command to reverse sort on Importance, and sort on Difficulty is
" "<,>!sort -t ',' -k 1,1r"
" 
" unordered input
" [I,D]
" [0,2] Low  important and High diff 3
" [1,2] Med  important and High diff 1
" [2,1] High important and Med  diff 2
" [1,1] Med  important and Med  diff 5
" [1,0] Med  important and Low  diff 4
" 
" ordered output
" [I,D]
" [2,1] High important and Med  diff 2
" [1,0] Med  important and Low  diff 4
" [1,1] Med  important and Med  diff 5
" [1,2] Med  important and High diff 1
" [0,2] Low  important and High diff 3

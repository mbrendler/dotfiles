
if(exists('g:loaded_ctrlp_find_alternatives')
    \ && g:loaded_ctrlp_find_alternatives)
    \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_find_alternatives = 1

call add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp#find_alternatives#init()',
	\ 'accept': 'ctrlp#find_alternatives#accept',
	\ 'lname': 'alternatives',
	\ 'sname': 'alt',
	\ 'type': 'line',
	\ 'sort': 1,
	\ 'specinput': 0,
	\ })


function! ctrlp#find_alternatives#init()
  return s:alternative_files
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#find_alternatives#accept(mode, str)
  call ctrlp#exit()
  let cmd = {"e": "edit", "v": "vsplit", "t": "tabnew", "h": "split"}[a:mode]
  execute ":" . l:cmd . " " . a:str
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#find_alternatives#start(search_filename)
  let s:alternative_files = ctrlp#find_alternatives#find(a:search_filename)
  if len(s:alternative_files) == 1
    execute ':edit ' . s:alternative_files[0]
  elseif empty(s:alternative_files)
    echom "no alternative files found"
  else
    call ctrlp#init(s:id)
  endif
endfunction

function! ctrlp#find_alternatives#find(search_filename)
  if exists('g:ctrlp_find_alternatives_endings')
    let endings = g:ctrlp_find_alternatives_endings
  else
    let endings = ['_test', '_spec']
  endif
  let filename = fnamemodify(a:search_filename, ':t')
  let extension = fnamemodify(a:search_filename, ':e')
  let basename = l:filename[0:-1 * len(l:extension) - 2]
  let remove_endings_pattern = '\v(' . join(endings, '$|') . '$)'
  let basename = substitute(l:basename, l:remove_endings_pattern, '', '')
  let singular = system('singularize ' . l:basename)
  let plural = system('pluralize ' . l:basename)
  let filenames = [l:singular . '.' . l:extension, l:plural . '.' . l:extension]
  for ending in endings
    call add(l:filenames, singular . ending . '.' . extension)
    call add(l:filenames, plural . ending . '.' . extension)
  endfor
  let found = system('find . -type f -name ' . join(filenames, ' -o -name ') . ' | grep -v "^./' . a:search_filename . '$"')
  let files = split(found, '\n')
  return l:files
endfunction


function! JavaScript_go_to_test()
  let l:filename = expand('%:r') . '.test.js'
  if file_readable(l:filename . 'x')
    let l:filename = l:filename . 'x'
  endif
  execute 'edit ' . l:filename
endfunction

function! JavaScript_go_to_implementation()
  let l:filename = expand('%:r:r') . '.js'
  if file_readable(l:filename . 'x')
    let l:filename = l:filename . 'x'
  end
  execute 'edit ' . l:filename
endfunction

function! JavaScript_toggle_test_and_impl_file()
  let l:filename = expand('%:r')
  echo l:filename
  if l:filename =~ '.test$'
    call JavaScript_go_to_implementation()
  else
    call JavaScript_go_to_test()
  endif
endfunction

" ----------------------------------------------------------------------------

function! TypeScript_go_to_test()
  let l:filename = expand('%:r') . '.test.ts'
  if file_readable(l:filename . 'x')
    let l:filename = l:filename . 'x'
  endif
  execute 'edit ' . l:filename
endfunction

function! TypeScript_go_to_implementation()
  let l:filename = expand('%:r:r') . '.ts'
  if file_readable(l:filename . 'x')
    let l:filename = l:filename . 'x'
  end
  execute 'edit ' . l:filename
endfunction

function! TypeScript_toggle_test_and_impl_file()
  let l:filename = expand('%:r')
  echo l:filename
  if l:filename =~ '.test$'
    call TypeScript_go_to_implementation()
  else
    call TypeScript_go_to_test()
  endif
endfunction

" ----------------------------------------------------------------------------

function! Filter_files_by_path(files, path)
  if len(a:files) == 1
    return a:files[0]
  endif

  if empty(a:files)
    return ''
  endif

  let l:sep = '/'
  let l:path = ''
  for l:path_element in reverse(split(a:path, l:sep))
    let l:path = l:path_element . l:sep . l:path
    let l:filtered_files = filter(a:files, {i, file -> file =~ l:path . fnamemodify(file, ':t')})
    if len(l:filtered_files) == 1
      return l:filtered_files[0]
    elseif empty(l:filtered_files)
      return a:files[0]
    endif
  endfor
  return ''
endfunction

function! Ruby_go_to_test()
  let l:base_filename = expand('%:t:r')
  let l:spec_filename = l:base_filename . '_spec.rb'
  let l:test_files = findfile(l:spec_filename, getcwd() . '/**', -1)
  let l:test_file = Filter_files_by_path(l:test_files, expand('%:h'))
  if l:test_file != ''
    execute 'edit ' . l:test_file
  else
    echo 'no test file found'
  endif
endfunction

function! Ruby_go_to_implementation()
  let l:base_filename = expand('%:t:r')
  if l:base_filename =~ '_spec$'
    let l:impl_filename = l:base_filename[:-6] . '.rb'
    let l:impl_files = findfile(l:impl_filename, getcwd() . '/**', -1)
    let l:impl_file = Filter_files_by_path(l:impl_files, expand('%:h'))
    if l:impl_file != ''
      execute 'edit ' . l:impl_file
    else
      echo 'no impl file found'
    endif
  endif
endfunction

function! Ruby_toggle_test_and_impl_file()
  let l:filename = expand('%:t:r')
  if l:filename =~ 'spec'
    call Ruby_go_to_implementation()
  else
    call Ruby_go_to_test()
  endif
endfunction

" ----------------------------------------------------------------------------

function! Python_go_to_test()
  let l:base_filename = expand('%:t:r')
  let l:test_filename = 'test_' . l:base_filename . '.py'
  let l:test_files = findfile(l:test_filename, getcwd() . '/**', -1)
  let l:test_file = Filter_files_by_path(l:test_files, expand('%:h'))
  if l:test_file != ''
    execute 'edit ' . l:test_file
  else
    echo 'no test file found'
  endif
endfunction

function! Python_go_to_implementation()
  let l:base_filename = expand('%:t')
  if l:base_filename =~ '^test_'
    let l:impl_filename = l:base_filename[5:]
    let l:impl_files = findfile(l:impl_filename, getcwd() . '/**', -1)
    let l:impl_file = Filter_files_by_path(l:impl_files, expand('%:h'))
    if l:impl_file != ''
      execute 'edit ' . l:impl_file
    else
      let l:impl_files = findfile(l:impl_filename . 'x', getcwd() . '/**', -1)
      let l:impl_file = Filter_files_by_path(l:impl_files, expand('%:h'))
      if l:impl_file != ''
        execute 'edit ' . l:impl_file
      else
        echo 'no impl file found'
      endif
    endif
  endif
endfunction

function! Python_toggle_test_and_impl_file()
  let l:filename = expand('%:t:r')
  if l:filename =~ 'test_'
    call Python_go_to_implementation()
  else
    call Python_go_to_test()
  endif
endfunction

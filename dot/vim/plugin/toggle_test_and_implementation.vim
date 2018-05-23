
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

function! Ruby_go_to_test()
  let l:base_filename = expand('%:t:r')
  let l:spec_filename = l:base_filename . '_spec.rb'
  let l:test_file = findfile(l:spec_filename, getcwd() . '/**')
  execute 'edit ' . l:test_file
endfunction

function! Ruby_go_to_implementation()
  let l:base_filename = expand('%:t:r')
  if l:base_filename =~ '_spec$'
    let l:impl_filename = l:base_filename[:-6] . '.rb'
    let l:impl_file = findfile(l:impl_filename, getcwd() . '/**')
    execute 'edit ' . l:impl_file
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

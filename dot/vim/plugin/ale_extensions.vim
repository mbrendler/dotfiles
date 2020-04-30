
function! ALE_extension_fixer_rbprettier(...)
  let l:command = 'rbprettier --write ' . expand('%')
  if Ruby_has_gemfile()
    let l:command = 'bundle exec ' . l:command
  endif
  call system(l:command)
endfunction


function! JavaScript_fix()
  write
  call system('eslint --fix ' . expand('%'))
  edit
  Neomake
endfunction

function! TypeScript_fix()
  write
  call system('tslint --fix ' . expand('%'))
  edit
  Neomake
endfunction

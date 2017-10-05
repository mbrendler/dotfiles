function! ToSnakeCaseLower(input)
  let l:result = substitute(a:input, '-', '_', 'g')
  let l:result = substitute(l:result, '^.', '\l\0', '')
  let l:result = substitute(l:result, '[A-Z]', '_\l\0', 'g')
  return l:result
endfunction

function! ToSnakeCaseUpper(input)
  return toupper(ToSnakeCaseLower(a:input))
endfunction

function! ToMinusCase(input)
  return substitute(ToSnakeCaseLower(a:input), '_', '-', 'g')
endfunction

function! ToCamelCase(input)
  return substitute(a:input, '[_-]\(\w\)', '\u\1', 'g')
endfunction

function! ToCamelCaseLower(input)
  return substitute(ToCamelCase(a:input), '^.', '\l\0', '')
endfunction

function! ToCamelCaseUpper(input)
  return substitute(ToCamelCase(a:input), '^.', '\u\0', '')
endfunction

function! ChangeWord(fn)
  let l:newWord = function(a:fn)(expand("<cword>"))
  execute ":normal ciw" . l:newWord
endfunction

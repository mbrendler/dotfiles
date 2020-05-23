setlocal suffixesadd+=.tsx
setlocal suffixesadd+=.ts
setlocal suffixesadd+=.jsx
setlocal suffixesadd+=.js
setlocal path+=./node_modules

nnoremap <buffer> <LocalLeader>o :call TypeScript_toggle_test_and_impl_file()<CR>
nnoremap <buffer> <LocalLeader>gs :execute ':edit ' . TypeScript_style_file()<CR>
nnoremap <buffer> <LocalLeader>gS :execute ':edit ' . TypeScript_story_file()<CR>
nnoremap <buffer> <LocalLeader>gt :execute ':edit ' . TypeScript_test_file()<CR>
nnoremap <buffer> <LocalLeader>gi :execute ':edit ' . TypeScript_implementation_file()<CR>

function! Typescript_base_filename()
  return expand('%:r:r')
endfunction

function! Typescript_find_file(filename)
  let l:suffixes = split(&suffixesadd, ',')
  for l:suffix in l:suffixes
    if filereadable(a:filename . l:suffix)
      return a:filename . l:suffix
    endif
  endif
  let l:current_extension = expand('%:e')
  return a:filename . '.' . l:current_extension
endfunction


function! TypeScript_style_file()
  let l:directory = expand('%:h')
  return l:directory . '/styles.tsx'
endfunction

function! TypeScript_story_file()
  return Typescript_find_file(Typescript_base_filename() . '.stories')
endfunction

function! TypeScript_test_file()
  return Typescript_find_file(Typescript_base_filename() . '.test')
endfunction

function! TypeScript_implementation_file()
  return Typescript_find_file(Typescript_base_filename())
endfunction

function! Typescript_find_test_name(filename, line)
  let l:test_name = ''

ruby <<EOF
  line_number = Vim.evaluate('a:line').to_i
  re = /^ *(describe|it|test)\( *('([^']+)'|"([^"]+)")/.freeze
  last_describe = nil
  last = ''
  open(Vim.evaluate('a:filename')).each_with_index do |line, i|
    break if i >= line_number
    match = re.match(line)
    next if match.nil?

    type = match[1]
    name = match[3] || match[4]
    last =
      if type == 'describe'
        last_describe = name
        name
      elsif last_describe.nil?
        name
      else
        "#{last_describe} #{name}"
      end
  end
  Vim.command("let l:test_name = '#{last}'")
EOF

  return l:test_name
endfunction

function! Run_typescript_file(filename, ...)
  if a:filename =~ '.test.tsx\?$'
    let l:command = 'yarn jest'
    if a:0 > 0
      let l:test_name = shellescape(Typescript_find_test_name(a:filename, a:1))
      let l:command = 'yarn jest -t ' . test_name
    endif
    call Run_run(l:command . ' ' . shellescape(a:filename), 1)
  else
    echom "Cannot run " . a:filename
  endif
endfunction

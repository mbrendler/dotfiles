setlocal suffixesadd+=.ts
setlocal suffixesadd+=.tsx

nnoremap <buffer> <LocalLeader>o :call TypeScript_toggle_test_and_impl_file()<CR>

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

function! Typescript_run(filename, ...)
  if a:filename =~ '.test.tsx\?$'
    let l:command = 'yarn jest'
    if a:0 > 0
      let l:test_name = shellescape(Typescript_find_test_name(a:filename, a:1))
      let l:command = 'yarn jest -t ' . test_name
    endif
    call Tmux_run_command(l:command . ' ' . shellescape(a:filename))
  else
    echom "Cannot run " . a:filename
  endif
endfunction

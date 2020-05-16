setlocal regexpengine=1 " improves performance with highlighting ruby files

function! Ruby_has_gemfile()
  return strlen(findfile('Gemfile', ';')) != 0
endfunction

function! Ruby_find_test_name(filename, line)
  let l:test_name = ''

ruby <<EOF
  line_number = Vim.evaluate('a:line').to_i
  re = /^ *def (test_[a-zA-Z0-9_]+)/.freeze
  last = ''
  open(Vim.evaluate('a:filename')).each_with_index do |line, i|
    break if i >= line_number
    match = re.match(line)
    next if match.nil?

    last = match[1]
  end
  Vim.command("let l:test_name = '#{last}'")
EOF

  return l:test_name
endfunction

function! Ruby_run(filename, ...)
  let l:command = 'ruby'
  let l:filename = shellescape(a:filename)
  if a:filename =~ '_spec.rb$'
    let l:command = 'rspec --format documentation'
    if a:0 > 0
      let l:filename = l:filename . ':' . a:1
    endif
  elseif a:filename =~ '_test.rb$' || a:filename =~ '^test_'
    if a:0 > 0
      let l:test_name = shellescape(Ruby_find_test_name(a:filename, a:1))
      let l:filename = l:filename . ' -n /' . l:test_name . '/'
    end
  endif
  if Ruby_has_gemfile()
    let l:command = 'bundle exec ' . l:command
  endif
  call Tmux_run_command(l:command . ' ' . l:filename)
endfunction

function! Ruby_run_interactive(filename)
  let l:command = 'pry'
  " if strlen(findfile('Gemfile', ';')) != 0
  "   let l:command = 'bundle exec ' . l:command
  " endif
  call Tmux_run_command(l:command . " --require " . getcwd() . '/' . a:filename)
endfunction

nnoremap <buffer> <LocalLeader>o :call Ruby_toggle_test_and_impl_file()<cr>

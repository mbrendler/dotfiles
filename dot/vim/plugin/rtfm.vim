function! Rtfm_perfom(search, command, filetype)
  let l:manual = system(a:command)
  if v:shell_error == 0
    tabnew
    execute "setlocal filetype=" . a:filetype
    setlocal modifiable
    setlocal noreadonly
    setlocal nolist
    setlocal colorcolumn=0
    setlocal nospell
    put! =l:manual
    setlocal nomodified
    setlocal readonly
    setlocal nomodifiable
    nnoremap <buffer> q :bw<cr>
    silent execute "file RTFM-'" . a:search . "'"
    1
    return 1
  else
    echo "no documentation entry for " . a:search
    return 0
  end
endfunction

function! Rtfm_ruby(search)
  call Rtfm_perfom(a:search, "ri --format=rdoc --no-pager " . a:search, "rdoc")
endfunction

function! Rtfm_erlang(search)
  call Rtfm_perfom(a:search, "MANPAGER='col -b -x' erl -man " . a:search, "man")
endfunction

function! Rtfm_elixir(search)
  " TODO: what's the correct filetype?
  if Rtfm_perfom(a:search, "~/.bin/elixir-man " . a:search, "elixir-doc") == 0
    call Rtfm_erlang(a:search)
  endif
endfunction

function! Rtfm_go(search)
  call Rtfm_perfom(a:search, "go fmt " + a:search, "")
endfunction

function! Rtfm_vim(search)
  execute "tab help " . a:search
  nnoremap <buffer> q :bw<cr>
endfunction

function! Rtfm_man(search)
  call Rtfm_perfom(a:search, "man -P 'col -b -x' " . a:search, "man")
endfunction

function! Rtfm(search)
  if &filetype == "ruby" || &filetype == "rdoc"
    call Rtfm_ruby(a:search)
  elseif &filetype == "elixir"
    call Rtfm_elixir(a:search)
  elseif &filetype == "erlang"
    call Rtfm_erlang(a:search)
  elseif &filetype == "vim" || &filetype == "help"
    call Rtfm_vim(a:search)
  else
    call Rtfm_man(a:search)
  end
endfunction

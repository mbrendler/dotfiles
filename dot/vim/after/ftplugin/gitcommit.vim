set spell

if !exists("g:gitcommit_comp_count")
  let g:gitcommit_comp_count = 30
endif

function! gitcommit#omnifunction(findstart, base)
  if a:findstart == 1
    return 0
  else
    let l:msg_str = system("git log --oneline --pretty=format:%s | head -n " . g:gitcommit_comp_count)
    let l:msgs = split(l:msg_str, "\n", 0)
    return filter(l:msgs, 'v:val =~ "^' . a:base . '"')
  end
endfunction

setlocal omnifunc=gitcommit#omnifunction

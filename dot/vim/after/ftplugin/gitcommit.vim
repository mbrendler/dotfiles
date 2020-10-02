setlocal spell

autocmd BufWinEnter,InsertEnter,InsertLeave * match Error /^# On branch master$/

if !exists("g:gitcommit_comp_count")
  let g:gitcommit_comp_count = 30
endif

function! gitcommit#omnifunction(findstart, base)
  if a:findstart
    return 0
  else
    let l:completions = gitcommit#last_commitmessages(g:gitcommit_comp_count)
    let l:branch = gitcommit#current_branch()
    if l:branch != 'master'
      let l:branch = tr(l:branch, '-', ' ')
      let l:branch = substitute(l:branch, '^.', '\u&', '')
      let l:completions = insert(l:completions, l:branch)
    end
    return filter(l:completions, 'v:val =~ "^' . a:base . '"')
  end
endfunction

function! gitcommit#last_commitmessages(count)
    let l:msg_str = system("git log --oneline --pretty=format:%s | head -n " . a:count)
    return split(l:msg_str, "\n", 0)
endfunction

function! gitcommit#current_branch()
  return trim(system("git rev-parse --abbrev-ref HEAD"))
endfunction

setlocal omnifunc=gitcommit#omnifunction

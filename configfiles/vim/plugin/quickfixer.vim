" File:         quickfixer.vim
" Author:       Maik Brendler (sellerieschnitzel@googlemail.com)
" Version:      0.1
" Description:  This plugin is inspired by 'javascriptlint.vim' by Joe
"               Stelmach (http://www.vim.org/scripts/script.php?script_id=2578)
"               Like 'javascriptLint.vim, it calls the makeprg, opens the
"               quickfix window and colorizes the current error line.  This is
"               done in a more general way by using the options 'makeprg' and
"               'errorformat'.
" Install:      Simply copy this file to '~/.vim/plugin/' and set 'makeprg'
"               and 'errorformat' for your filetypes.  After that
"               'call QuickFixer()' function.  Or call it with the command
"               'autocmd BufWritePost,FileWritePost *.py call QuickFixer()'
"               on every file save.
" Last Modified: 28 May 2012

autocmd BufWinLeave * call s:QuickFixerEnd()

if !exists('quickfixer_highlight_color')
  let quickfixer_highlight_color = 'orange'
endif

function QuickFixer()
  silent make
  if s:QuickFixListHasRealEntries()
    call s:SetCursorLineColor()
    botright copen
  else
    call s:QuickFixerEnd()
  endif
endfunction

function s:QuickFixerEnd()
  call s:ClearCursorLineColor()
  cclose
endfunction

function s:QuickFixListHasRealEntries()
  for l:qfentry in getqflist()
    if l:qfentry['lnum'] > 0
      return 1
    endif
  endfor
  return 0
endfunction

function s:SetCursorLineColor()
  redir => l:highlight_info
    silent highlight CursorLine
  redir END
  let l:start_index = match(l:highlight_info, 'guibg')
  if(l:start_index > 0)
    let s:previous_cursor_guibg = strpart(l:highlight_info, l:start_index)
  elseif(exists('s:previous_cursor_guibg'))
    unlet s:previous_cursor_guibg
  endif
  execute 'highlight CursorLine guibg=' . g:quickfixer_highlight_color
endfunction

function s:ClearCursorLineColor()
  if exists('s:previous_cursor_guibg')
    execute 'highlight CursorLine ' . s:previous_cursor_guibg
    unlet s:previous_cursor_guibg
  else
    highlight clear CursorLine
  endif
endfunction

" Maintainer:	Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.0
" Last Change:	September 25 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mustang"

" Vim >= 7.0 specific colors
if version >= 700
  hi clear CursorLine
  hi CursorLine guibg=#2d2d2d ctermbg=236
  hi clear CursorColumn
  hi CursorColumn guibg=#2d2d2d ctermbg=236
  hi ColorColumn ctermbg=59
  hi MatchParen guifg=#d0ffc0 guibg=#2f2f2f gui=bold cterm=bold,inverse
  hi Pmenu 		guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
  hi PmenuSel 	guifg=#000000 guibg=#b1d631 ctermfg=0 ctermbg=148
endif

""" Change StatusLine, CursorLine and CursorColumn color in insert mode:
augroup ModeDetection
  autocmd!
  autocmd InsertEnter *
    \ hi StatusLine guibg=#bb1111 ctermfg=52 ctermbg=255 |
    \ hi CursorLine guibg=#c9d9e9 ctermbg=52 |
    \ hi CursorColumn guibg=#c9d9e9 ctermbg=52
  autocmd InsertLeave *
    \ hi StatusLine guibg=#8090a0 ctermfg=253 ctermbg=238 |
    \ hi CursorLine guibg=#f6f6f6 ctermbg=236 |
    \ hi CursorColumn guibg=#eaeaea ctermbg=236
augroup END

" General colors
hi Cursor 		guifg=NONE    guibg=#626262 gui=none ctermbg=241
hi Normal 		guifg=#e2e2e5 guibg=#202020 gui=none ctermfg=253 ctermbg=234
hi NonText 		guifg=#808080 guibg=#303030 gui=none ctermfg=244 ctermbg=235
hi LineNr 		guifg=#808080 guibg=#000000 gui=none ctermfg=244 ctermbg=232
hi StatusLine 	guifg=#d3d3d5 guibg=#444444 gui=italic ctermfg=253 ctermbg=238 cterm=italic
hi StatusLineNC guifg=#939395 guibg=#444444 gui=none ctermfg=246 ctermbg=238
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none ctermfg=238 ctermbg=238
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none ctermbg=4 ctermfg=248
hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold ctermfg=254 cterm=bold
hi Visual		guifg=#faf4c6 guibg=#3c414c gui=none ctermfg=254 ctermbg=4
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none ctermfg=244 ctermbg=236

" Syntax highlighting
hi Comment 		guifg=#808080 gui=italic ctermfg=244
hi Todo 		guifg=#8f8f8f gui=italic ctermfg=245
hi Boolean      guifg=#b1d631 gui=none ctermfg=94
hi String 		guifg=#b1d631 gui=italic ctermfg=31
hi Identifier 	guifg=#b1d631 gui=none ctermfg=94
hi Function 	guifg=#ffffff gui=bold ctermfg=255
hi Type 		guifg=#7e8aa2 gui=none ctermfg=103
hi Statement 	guifg=#7e8aa2 gui=none ctermfg=103
hi Keyword		guifg=#ff9800 gui=none ctermfg=208
hi Constant 	guifg=#ff9800 gui=none  ctermfg=208
hi Number		guifg=#ff9800 gui=none ctermfg=208
hi Special		guifg=#ff9800 gui=none ctermfg=208
hi PreProc 		guifg=#faf4c6 gui=none ctermfg=230
hi Todo         guifg=#000000 guibg=#e6ea50 gui=italic


" Search
hi Search ctermbg=226 ctermfg=0
hi IncSearch term=reverse cterm=reverse gui=reverse

" Spelling
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=210
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=13

" Code-specific colors
hi pythonOperator guifg=#7e8aa2 gui=none ctermfg=103


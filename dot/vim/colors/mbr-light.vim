set background=light

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mbr-light"

if version >= 700
  hi ColorColumn guibg=#ffd7ff gui=none ctermbg=224 cterm=none
  hi CursorLine guibg=#f6f6f6 gui=none ctermbg=231 cterm=none
  hi CursorColumn guibg=#eaeaea cterm=none ctermbg=252
  hi MatchParen guifg=white guibg=#80a090 gui=bold cterm=bold ctermbg=66

  " TODO
  "Tabpages
  hi TabLine guifg=black guibg=#b0b8c0 gui=italic ctermfg=16 ctermbg=239 cterm=italic
  hi TabLineFill guifg=#9098a0 ctermbg=239
  hi TabLineSel guifg=black guibg=#f0f0f0 gui=italic,bold ctermfg=16 ctermbg=252 cterm=bold

  "P-Menu (auto-completion)
  hi Pmenu guifg=#ffffff guibg=#808080 gui=none ctermfg=231 ctermbg=244 cterm=none
  hi PmenuSel gui=none cterm=none ctermbg=16 ctermfg=254
  "PmenuSbar
  "PmenuThumb
  hi WildMenu ctermfg=16 ctermbg=226 cterm=none

  hi SignColumn gui=none ctermfg=16 ctermbg=248 cterm=none
endif

augroup ModeDetection
  autocmd!
  autocmd InsertEnter *
    \ hi StatusLine guibg=#bb1111 ctermfg=75 ctermbg=238 |
    \ hi CursorLine guibg=#c9d9e9 ctermbg=52  ctermfg=252 |
    \ hi CursorColumn guibg=#c9d9e9 ctermbg=52
  autocmd InsertLeave *
    \ hi StatusLine guifg=white guibg=#8090a0 gui=bold,italic ctermfg=231 ctermbg=25 cterm=bold,italic |
    \ hi CursorLine guibg=#f6f6f6 cterm=none ctermbg=231 ctermfg=none |
    \ hi CursorColumn guibg=#eaeaea cterm=none ctermbg=252
augroup END

hi SpellBad gui=none ctermfg=160 cterm=none,underline,bold
hi SpellCap gui=none ctermfg=160 cterm=none,underline,bold
hi SpellLocal gui=none ctermfg=103 cterm=none,underline,bold
hi SpellRare gui=none ctermfg=106 cterm=none,underline,bold

" Html-Titles
hi Title      guifg=#202020 gui=bold ctermfg=234 cterm=bold
hi Underlined  guifg=#202020 gui=underline ctermfg=234 cterm=underline


hi Cursor    guifg=black   guibg=#b0b4b8
hi lCursor   guifg=black   guibg=white
hi LineNr    guifg=#000000 guibg=#c0d0e0 ctermfg=16 ctermbg=249

hi Normal guifg=#404850 guibg=#f0f0f0 ctermfg=239 ctermbg=254
hi Visual ctermfg=254 ctermbg=4

hi Search ctermbg=226 ctermfg=0
hi IncSearch term=reverse cterm=reverse gui=reverse
hi QuickFixLine term=reverse cterm=reverse gui=reverse

hi StatusLine guifg=white guibg=#8090a0 gui=bold,italic ctermfg=231 ctermbg=25 cterm=bold,italic
hi StatusLineNC guifg=#506070 guibg=#a0b0c0 gui=italic ctermfg=16 ctermbg=243 cterm=italic
hi VertSplit guifg=#a0b0c0 guibg=#a0b0c0 gui=none ctermfg=243 ctermbg=243 cterm=none
hi WinSeparator guifg=#a0b0c0 guibg=#a0b0c0 gui=none ctermfg=243 ctermbg=243 cterm=none

" hi Folded    guifg=#708090 guibg=#c0d0e0
hi Folded    guifg=#a0a0a0 guibg=#e8e8e8 gui=italic

hi NonText ctermfg=250 cterm=italic
" Kommentare
hi Comment   guifg=#a0b0c0 gui=italic ctermfg=243 cterm=italic

" Konstanten
hi Constant  guifg=#a07040 ctermfg=94
hi String    guifg=#4070a0 ctermfg=24
hi Number    guifg=#40a070 ctermfg=30
hi Float     guifg=#70a040 ctermfg=28
"hi Statement guifg=#0070e0 gui=NONE
" Python: def and so on, html: tag-names
hi Statement  guifg=#007020 gui=bold ctermfg=23 cterm=bold


" HTML: arguments
hi Type       guifg=#e5a00d gui=italic ctermfg=130 cterm=italic
" Python: Standard exceptions, True&False
hi Structure  guifg=#007020 gui=italic ctermfg=23 cterm=italic
hi Function   guifg=#06287e gui=italic ctermfg=17 cterm=italic

hi Identifier guifg=#5b3674 gui=italic ctermfg=60 cterm=italic

hi Repeat      guifg=#7fbf58 gui=bold ctermfg=29 cterm=bold
hi Conditional guifg=#4c8f2f gui=bold ctermfg=28 cterm=bold

" Cheetah: #-Symbol, function-names
hi PreProc    guifg=#1060a0 gui=NONE ctermfg=25 cterm=none
" Cheetah: def, for and so on, Python: Decorators
hi Define      guifg=#1060a0 gui=bold ctermfg=25 cterm=bold

hi Error      guifg=red guibg=white gui=bold,underline ctermfg=160 ctermbg=none cterm=bold,underline
hi Todo       guifg=#a0b0c0 guibg=NONE gui=italic,bold,underline ctermfg=243, ctermbg=none cterm=bold

" Python: %(...)s - constructs, encoding
hi Special    guifg=#70a0d0 gui=italic ctermfg=33 cterm=italic

hi Operator   guifg=#408010 ctermfg=28

" color of <TAB>s etc...
"hi SpecialKey guifg=#d8a080 guibg=#e8e8e8 gui=italic
hi SpecialKey guifg=#d0b0b0 guibg=#f0f0f0 gui=none ctermfg=138 ctermbg=254 cterm=none

" Diff
hi DiffChange guifg=NONE guibg=#e0e0e0 gui=italic,bold
hi DiffText guifg=NONE guibg=#f0c8c8 gui=italic,bold
hi DiffAdd guifg=NONE guibg=#c0e0d0 gui=italic,bold
hi DiffDelete guifg=NONE guibg=#f0e0b0 gui=italic,bold

hi CocFloating ctermbg=251

nnoremap <silent> <buffer> <C-]>    :call man#get_page(v:count, expand('<cword>'))<CR>
nnoremap <silent> <buffer> <C-T>    :call man#pop_page()<CR>

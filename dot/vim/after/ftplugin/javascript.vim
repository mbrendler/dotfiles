setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ '$HOME/.jsl.conf'\ -process\ %
setlocal errorformat=%f(%l):\ %m

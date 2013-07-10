" recognize .ticket files
if has("autocmd")
    autocmd BufNewFile,BufRead *.ticket setf ticket
endif

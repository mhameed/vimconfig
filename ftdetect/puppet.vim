" recognize puppet files
if has("autocmd")
    autocmd BufNewFile,BufRead *.pp setf puppet
endif

function! MhFoldText()
  let foldsize = v:foldend - v:foldstart + 1
  let  text = '# ' . foldsize . ' hidden lines.' 
  let ind = indent(v:foldstart)
  let trail = 80-(strlen(text)+ind)
  return repeat(' ', ind) . text  . repeat(' ', trail)
endfunction
set foldtext=MhFoldText()



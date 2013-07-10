
"set foldmethod=syntax"
"set fdc=0"


set foldmethod=expr 
set foldexpr=PythonFoldExpr(v:lnum) 
set foldtext=PythonFoldText() 

map <buffer> f za 
map <buffer> F :call ToggleFold()<CR> 
let b:folded = 1 

function! ToggleFold() 
    if( b:folded == 0 ) 
        exec "normal! zM" 
        let b:folded = 1 
    else 
        exec "normal! zR" 
        let b:folded = 0 
    endif 
endfunction 

function PythonFoldText() 
    let size = 1 + v:foldend - v:foldstart 
     
    if match(getline(v:foldstart), '"""') >= 0 
        let text = substitute(getline(v:foldstart), '"""', '', 'g' ) . ' ' 
    elseif match(getline(v:foldstart), "'''") >= 0 
        let text = substitute(getline(v:foldstart), "'''", '', 'g' ) . ' ' 
    else 
        let text = getline(v:foldstart) 
    endif 
    let spc = MakeSpace(indent(v:foldstart)) 
    let mres = spc . "# (" . size . ")"
    call setLine(v:lnum, mres)
    return mres
endfunction 

function! PythonFoldExpr(lnum) 
    if indent( nextnonblank(a:lnum) ) == 0 
        return 0 
    endif 
     
    if getline(a:lnum) =~ '^\s*\(class\|def\)\s' 
        return indent(a:lnum)/4 
    endif 

    if getline(a:lnum) =~ '^\s*$' 
        if getline(nextnonblank(a:lnum)) =~ '^\s*def\s'
            return indent(nextnonblank(a:lnum))/4
        endif 
        return  '='
    endif

    if indent(a:lnum) == 0 
        return 0 
    endif 

    return indent(a:lnum)/4
endfunction 

" In case folding breaks down 
function! ReFold() 
    set foldmethod=expr 
    set foldexpr=0 
    set foldnestmax=1 
    set foldmethod=expr 
    set foldexpr=PythonFoldExpr(v:lnum) 
    set foldtext=PythonFoldText() 
    echo 
endfunction 



function MakeSpace(lnum)
    let res = ""
    for i in range(1, a:lnum)
        let res = res . " "
    endfor
    return res
endfunction


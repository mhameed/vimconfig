""" Don't be backward compatible with vi:
set nocompatible

""" general
"{{{
"turn on syntax highlighting
syntax on
"the terminal has 256 colors
set t_Co=256

set encoding=utf-8
set nobackup
set noswapfile

"Minimize movement, also remove anything that might force a redraw of the
"bottom of the screen.
"Orca will get the text between the cursor and the end of the screen, which is
"unpleasant to listen to.
set laststatus=0
set noruler
set statusline=
set scrolljump=18
set scrolloff=0
set scroll=20

""" tabification:
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"show matching brackets (),{},[]
set showmatch
"show matching brackets for 2 seconds so that we get a chanse to read it with the braille display.
set mat=20
"}}}

""" Searching:
"{{{
"Use normal regexp characters rather than vims.
nnoremap / /\v
vnoremap / /\v
"Match more than just first hit.
set gdefault

set incsearch
set smartcase
set ignorecase
"}}}

""" plugins:
"{{{
"activate pathogen
call pathogen#infect()

"load ftplugins and indent files
filetype plugin on
filetype indent on

"Don't use default ultiSnip snippets, only our custom Incantations.
let g:UltiSnipsSnippetDirectories=["personalSnippets"]
"}}}

""" Mappings:
"{{{
set pastetoggle=<F2>
nnoremap <F5> :setlocal spell! spelllang=en_gb<CR>

inoremap kj <esc>

"Exit insert mode asap
inoremap <Right> <Esc>
inoremap <Left> <Esc>
inoremap <Up> <Esc><Up>
inoremap <Down> <Esc><Down>

"Reduce the need for pressing shift.
nnoremap ; :
nnoremap : <NOP>
nnoremap <leader>; ;

""" nnoremap <leader>q q
""" nnoremap q :q<cr>

"Train mussle memory, make it extra irritating to move more than 1 char in either direction.
"we can get there faster by not using arrow keys.
nnoremap <Right><Right> <NOP>
nnoremap <Left><Left> <NOP>

"Don't sit around in insert mode. 
au CursorHoldI * stopinsert
"set 'updatetime' to 10 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=10000
au InsertLeave * let &updatetime=updaterestore


let mapleader = ","

"strip all trailing whitespace in the file.
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
"}}}

""" Tabline setup:
"{{{

"tabline always visible
"Makes vim first line readable in gnome-term with orca.
set showtabline=2

" Move most of the things that use to be in the status line to the tabline,
" since the tabline doesn't interfear with reading, while the statusline does. 

set tabline=vim\ 
set tabline+=%#identifier#
set tabline+=%t    "tail of the filename
set tabline+=%*

"display a warning if fileformat isnt unix
set tabline+=%#warningmsg#
set tabline+=%{&ff!='unix'?'\ '.&ff:''}
set tabline+=%*

"display a warning if file encoding isnt utf-8
set tabline+=%#warningmsg#
set tabline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set tabline+=%*

set tabline+=%h      "help file flag
set tabline+=%y      "filetype

"read only flag
set tabline+=%#identifier#
set tabline+=%r
set tabline+=%*

"modified flag
set tabline+=%#identifier#
set tabline+=%m
set tabline+=%*
"}}}

if v:version >= 703
    "undo settings
    set undodir=~/.vim/.undo
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

source ~/.vim/autocorrect.vim

source ~/.vim/preferedIndent.vim
set foldmethod=indent
set foldlevelstart=1

function! s:RunShellCommand(cmdline)
  botright lwindow
"  lexpr system(escape(a:cmdline,'%#'))
  lexpr system(a:cmdline)
  lopen
  1
endfunction

command -complete=file Test call s:RunShellCommand('python '.expand('%'))
command -complete=file Pylint call s:RunShellCommand('pylint '.expand('%'))

let g:pymode_folding = 0
let g:pymode_lint_signs = 0
let g:pymode_options = 0

" Map key to toggle opt taken from:
" http://vim.wikia.com/wiki/Quick_generic_option_toggling
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Display-altering option toggles
MapToggle <leader>l number

" vim: foldmethod=marker foldlevel=0

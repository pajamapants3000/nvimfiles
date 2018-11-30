" File ts.vim
" typescript-specific vim configuration

"**********
" Mappings
"^^^^^^^^^^

"**************
" Vim Settings
"^^^^^^^^^^^^^^
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal foldmethod=syntax
setlocal foldlevel=99
setlocal showcmd
setlocal incsearch
setlocal nowrap
setlocal nospell

setlocal commentstring=/*\ %s\ */

"******
" Tags
"^^^^^^
if has('win32')
    setlocal tags+=$HOME\ctags\ts.tags
else
    setlocal tags+=$HOME/.config/ctags/ts.tags
endif


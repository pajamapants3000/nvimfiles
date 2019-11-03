" File rust.vim
" rust-specific vim configuration

"**********
" Mappings
"^^^^^^^^^^

"**************
" Vim Settings
"^^^^^^^^^^^^^^
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal foldmethod=syntax
setlocal foldlevel=99
setlocal showcmd
setlocal incsearch
setlocal nowrap
setlocal nospell

setlocal colorcolumn=120
highlight ColorColumn ctermbg=darkgray

setlocal commentstring=/*\ %s\ */

"******
" Tags
"^^^^^^
if has('win32')
    setlocal tags+=$HOME\ctags\rust.tags
else
    setlocal tags+=$HOME/.config/ctags/rust.tags
endif



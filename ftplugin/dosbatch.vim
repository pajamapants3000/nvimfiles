" Vim filetype plugin file
" Language:    MS-DOS .bat files

let s:cpo_save = &cpo
set cpo&vim

setlocal commentstring=::\ %s

let &cpo = s:cpo_save
unlet s:cpo_save

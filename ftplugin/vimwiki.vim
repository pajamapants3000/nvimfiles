" File vimwiki.vim
" vimwiki file-type plugin

" the wiki file will make more use of this than most; I'm using
" the vim-tasklist tokens to implement the tags of OneNote, at least
" somewhat
if !exists('g:tlTokenList')
    let g:tlTokenList = ['FIXME', 'TODO', 'XXX']
endif
let g:tlTokenList += [ 'QQQ' ]                  " unanswered question
let g:tlTokenList += [ 'REV' ]                  " review information
let g:tlTokenList += [ 'REVQ' ]                 " review question
let g:tlTokenList += [ 'REVA' ]                 " review answer
let g:tlTokenList += [ 'QnA' ]                  " answered question
let g:tlTokenList += [ 'NOTE' ]                 " important point
let g:tlTokenList += [ 'IDEA' ]                 " idea
let g:tlTokenList += [ 'OOH' ]                  " very interesting
let g:tlTokenList += [ 'TIP' ]                  " tip or suggestion
let g:tlTokenList += [ 'CHAL' ]                 " challenge
let g:tlTokenList += [ 'CARE' ]                 " warning/caution/be careful
let g:tlTokenList += [ 'LATR' ]                 " come back to this later
let g:tlTokenList += [ 'BTW' ]                  " an aside (by the way)
let g:tlTokenList += [ 'TIP' ]                  " a handy suggestion
let g:tlTokenList += [ 'WHOA' ]                 " a warning; caution
let g:tlTokenList += [ 'AHA' ]                  " clarifies/reveals
let g:tlTokenList += [ 'TEST' ]                 " need to test this
let g:tlTokenList += [ 'ME' ]                   " just my own commentary
let g:tlTokenList += [ 'EG' ]                   " example

" Add tasklist tokens to Todo highlighting
call TlTokenHi()

"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" Vim settings
"**************
"setlocal textwidth=80
setlocal textwidth=0
setlocal formatoptions+=t
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal showcmd
setlocal incsearch
setlocal nowrap
setlocal spell
setlocal indentexpr=
setlocal foldenable
setlocal foldmethod=marker
setlocal foldlevel=99
set nobuflisted

"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" Functions
"***********
"
"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" Mappings
"**********
" Insert line break, followed by actual carriage return
inoremap br<CR> <br /><CR>

" Create Wiki Links
" links to chapters
nnoremap <leader>wll :<c-u>.,$s/^\(..*\)$/*<space>[[\1\/index<bar>\1]]/<cr>
" links to pages
nnoremap <leader>wlo :<c-u>.,$s/^\(..*\)$/*<space>[[\1<bar>\1]]/<cr>
" replace characters with underscore
nnoremap <leader>wl<leader>t
            \ :<c-u>.,$s/\*<space>\[\[\(.*\)[^-a-zA-Z0-9.&/_]\(.*\)<bar>/*<space>[[\1_\2<bar>/<cr>
" alternate replace characters with underscore
nmap <leader>wl<leader>r
            \ <c-o><leader>wl<leader>t
"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


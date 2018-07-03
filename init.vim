" $LOCALAPPDATA/nvim/init.vim
"
" Neovim configuration file
" Currently 100% Windows-configured

" **************************************************************************** "

" *** Definitions *** "
let g:NeovimConfigurationDirectory = $LOCALAPPDATA.'/nvim'
let g:ExtendDirectory = $NeovimConfigurationDirectory.'/extend'

let g:filetype_aliases = {}
let g:filetype_aliases['c++']         = 'cpp'
let g:filetype_aliases['cpp']         = 'cpp'
let g:filetype_aliases['python']      = 'python'
let g:filetype_aliases['asm']         = 'asm'
let g:filetype_aliases['rust']        = 'rust'
let g:filetype_aliases['go']          = 'go'
let g:filetype_aliases['rkt']         = 'racket'
let g:filetype_aliases['racket']      = 'racket'
let g:filetype_aliases['sh']          = 'sh'
let g:filetype_aliases['make']        = 'make'
let g:filetype_aliases['lua']         = 'lua'
let g:filetype_aliases['hla']         = 'hla'
let g:filetype_aliases['toml']        = 'toml'
let g:filetype_aliases['xml']         = 'xml'
let g:filetype_aliases['asp']         = 'aspnet'
let g:filetype_aliases['aspnet']      = 'aspnet'
let g:filetype_aliases['c']           = 'c'
let g:filetype_aliases['ps1']         = 'ps1'
let g:filetype_aliases['sql']         = 'sql'
let g:filetype_aliases['html']        = 'html'
let g:filetype_aliases['js']          = 'javascript'
let g:filetype_aliases['javascript']  = 'javascript'
let g:filetype_aliases['vbs']         = 'vbs'
let g:filetype_aliases['vb']          = 'vb'
let g:filetype_aliases['xaml']        = 'xaml'
let g:filetype_aliases['sharp']       = 'cs'
let g:filetype_aliases['razor']       = 'cshtml'
let g:filetype_aliases['razorvb']     = 'vbhtml'

" *** Functions *** "
function! NumberToggleRel()
    if(&number == 1)
        if(&relativenumber == 1)
            set norelativenumber
        else
            set relativenumber
        endif
    endif
endfunc
"
function! NumberToggle()
    if(&relativenumber == 1)
        if(&number == 1)
            set norelativenumber
            set nonumber
        else
            set number
        endif
    else
        if(&number == 1)
            set nonumber
        else
            set number
        endif
    endif
endfunc
" Add all tasklist identifiers to Todo highlighting
function! TlTokenHi()
    if exists('g:tlTokenList')
        for token in g:tlTokenList
            " for some reason, couldn't get `match` to work!
            execute "syn keyword tlToken " . token
        endfor
        hi link tlToken Todo
    endif
endfunc
" SetFileType: set filetype to alias under cursor
function! SetFileType(alias)
    if has_key(g:filetype_aliases, a:alias)
        let filetype = g:filetype_aliases[a:alias]
    elseif tolower(a:alias) == 'vimwiki'
        let filetype = 'vimwiki'
    else
        let filetype = 'text'
    endif
    :execute 'setf ' . filetype
    :execute 'do BufRead x.' . filetype
    return filetype
endfunc

" *** Early-Set Options *** "

" *** Plugins *** "
" TODO: figure out how to use g:ExtendDirectory here; doesn't expand correctly and `execute 'call...' ...` doesn't work.
call plug#begin('~/AppData/Local/nvim/extend')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'fholgado/minibufexpl.vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
    \ }

" (Optional) Multi-entry selection UI. Run install script in repo
Plug 'junegunn/fzf'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'tmhedberg/matchit'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'juneedahamed/vc.vim'
Plug 'scrooloose/syntastic'

" * Syntax Highlighting * "
Plug 'vim-jp/vim-cpp'
Plug 'OrangeT/vim-csharp'
Plug 'yuratomo/dotnet-complete'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/vbnet.vim'
Plug 'vim-scripts/aspnet.vim'
Plug 'sirtaj/vim-openscad'
Plug 'PProvost/vim-ps1'
Plug 'vim-scripts/fitnesse.vim'

" * Theme * "
Plug 'pajamapants3000/vim-colorstepper'
Plug 'notpratheek/vim-luna'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'veloce/vim-aldmeris'
Plug 'vim-scripts/zenesque.vim'
Plug 'trapd00r/neverland-vim-theme'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'shiracha/shiracha-vim'
Plug 'w0ng/vim-hybrid'
Plug 'sk1418/last256'

" * More * "
Plug 'pajamapants3000/vimwiki'

call plug#end()

" *** Plugin Configurations *** "

" * scrooloose/nerdtree * "
let NERDTreeShowLineNumbers=0
map <F2> :NERDTreeToggle<CR>
map <leader>d :Bookmark
map <leader>b :OpenBookmark

" * mhinz/vim-signify * "
let g:signify_vcs_list = [ 'git', 'hg', 'tfs' ]
let g:signify_difftool = 'fc'

" * vim-airline/vim-airline * "
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 12
let g:airline#extensions#branch#format = 2
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ [ 'x', 'y', 'z', 'error', 'warning' ]
  \ ]
let g:airline#extensions#whitespace#trailing_format = 'tr[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mxin[%s]'
let g:airline#extensions#whitespace#long_format = 'long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mxin-file[%s]'

" qualiabyte/vim-colorstepper
nmap <F6> <Plug>ColorstepPrev
nmap <F7> <Plug>ColorstepNext
nmap <S-F7> <Plug>ColorstepReload

" * autozimu/LanguageClient-neovim * "
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ }
"    \ 'lua': ['lua-lsp'],
"    \ 'sh': ['bash-language-server', 'start'],

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" * Shougo/deoplete.nvim * "
let g:deoplete#enable_at_startup = 1

" * scrooloose/syntastic * "
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" * pajamapants3000/vimwiki * "
let wiki = {}
" taken from default dictionary; comment out defaults and add any changes
let wiki.maxhi = 0
let wiki.css_name = 'style.css'
let wiki.auto_export = 1
let wiki.diary_index = 'index'
let wiki.template_default = 'default'
let wiki.auto_toc = 1
let wiki.auto_tags = 0
let wiki.nested_syntaxes = g:filetype_aliases
let wiki.diary_sort = 'desc'
let wiki.path = '~/vimwiki/'
let wiki.path_html = wiki.path . '../vimwiki_html/'
let wiki.template_path = wiki.path . 'templates/'
let wiki.diary_link_fmt = '%Y-%m-%d'
let wiki.template_ext = '.tpl'
let wiki.syntax = 'default'
let wiki.custom_wiki2html = ''
let wiki.automatic_nested_syntaxes = 1
let wiki.index = 'index'
let wiki.diary_header = 'Diary'
let wiki.ext = '.wiki'
let wiki.temp = 0
let wiki.list_margin = -1
let wiki.diary_rel_path = 'diary/'
let wiki_fitnesse = {}
let wiki_fitnesse.css_name = 'style.css'
let wiki_fitnesse.path = 'C:/Fitnesse/FitnesseRoot'
let wiki_fitnesse.syntax = 'fitnesse'
let wiki_fitnesse.ext = '.wiki'
let g:vimwiki_folding = 'expr'
let g:vimwiki_list = [wiki, wiki_fitnesse]
let g:vimwiki_hl_headers = 1
let g:vimwiki_use_calendar = 1
let g:vimwiki_html_header_numbering = 0

" * tpope/vim-surround * "
nmap `` ysiw`
nmap (( ysiw(
nmap )) ysiw)
nmap [[ ysiw[
nmap ]] ysiw]
nmap {{ ysiw{
nmap }} ysiw}

" *** Mappings *** "
" Switch windows, simpler keybindings
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" Quick-escape/normal-mode
inoremap jj <Esc>
" Set filetype to filetype corresponding to alias under the cursor
nnoremap <leader>ff :<c-u>redir<space>@z<CR>
            \:<c-u>exe<space>'echo<space>"filetype<space>is<space>now<space>'
            \.SetFileType(expand('<cword>')).'"'<CR>
            \:<c-u>redir<space>END<CR>ciw<ESC>
            "\:<c-u>echo<space>@z<CR>
inoremap <leader>ff <c-o>:redir<space>@z<CR>
            \<c-o>:exe<space>'echo<space>"filetype<space>is<space>now<space>'
            \.SetFileType(expand('<cword>')).'"'<CR>
            \<c-o>:redir<space>END<CR><c-o>ciw<ESC>
            "\<c-o>:echo<space>@z<CR>
" Set filetype to vimwiki
nnoremap <leader>fv :<c-u>redir<space>@z<CR>
            \:<c-u>exe<space>'echo<space>"filetype<space>is<space>now<space>'
            \.SetFileType('vimwiki').'"'<CR>
            \:<c-u>redir<space>END<CR>
            "\:<c-u>echo<space>@z<CR>
inoremap <leader>fv <c-o>:redir<space>@z<CR>
            \<c-o>:exe<space>'echo<space>"filetype<space>is<space>now<space>'
            \.SetFileType('vimwiki').'"'<CR>
            \<c-o>:redir<space>END<CR>
            "\<c-o>:echo<space>@z<CR>
" Create Wiki Links
nnoremap <leader>wll :<c-u>.,$s/^\(..*\)$/*<space>[[\1\/index<bar>\1]]/<cr>
nnoremap <leader>wlo :<c-u>.,$s/^\(..*\)$/*<space>[[\1<bar>\1]]/<cr>
nnoremap <leader>wl<leader>t
            \ :<c-u>.,$s/\*<space>\[\[\(.*\)[^-a-zA-Z0-9./_]\(.*\)<bar>/*<space>[[\1_\2<bar>/<cr>
nmap <leader>wl<leader>r
            \ <c-o><leader>wl<leader>t

" *** AutoCommands *** "
" Toggle number/relativenumber when entering/leaving buffer - more useful display
:au FocusLost * :set norelativenumber
:au FocusGained * :set relativenumber
autocmd InsertEnter * :call NumberToggleRel()
autocmd InsertLeave * :call NumberToggleRel()

" Pick up desired filetypes and source any appropriate configuration
augroup filetypedetect
    " Mail
    autocmd BufNewFile,BufRead,BufEnter *mutt-* setf mail
    " VB.NET
    au BufNewFile,BufRead,BufEnter *.aspx.vb    setf vbnet
    " ASP.NET
    au BufNewFile,BufRead,BufEnter *.aspx       setf aspnet
    " Python
    au BufNewFile,BufRead,BufEnter *.py,*.py2,*.py3,*.pyw   setf python
    " Makefiles
    au BufNewFile,BufRead,BufEnter
                \ [Mm]akefile{,.*},*.{make,mak,mk}
                \ setf make
    " C
    au BufNewFile,BufRead,BufEnter *.[ch]       setf c
    " C++
    au BufNewFile,BufRead,BufEnter *.[ch]{xx,++,pp},*.C     setf cpp
    " XAML
    au BufNewFile,BufRead,BufEnter *.xaml       setf xml
    au BufNewFile,BufRead,BufEnter *.xaml       setl omnifunc=xaml#complete
    " Rust
    au BufNewFile,BufRead,BufEnter *.rst        setf rust
    " HTML
    au BufNewFile,BufRead,BufEnter *.htm{,l}    setf html
    " CSS
    au BufNewFile,BufRead,BufEnter *.css        setf css
    " HLA
    au BufNewFile,BufRead,BufEnter *.h{la,hf}   setf hla
    " Racket
    au BufNewFile,BufRead,BufEnter *.rkt        setf racket
    " Pollen
    au BufNewFile,BufRead,BufEnter *.p{,p,m,md,tree}  setf pollen
    " Vim
    au BufNewFile,BufRead,BufEnter *.vim              setf vim
    au BufNewFile,BufRead,BufEnter {,.,.g,_,_g}vimrc  setf vim

augroup END

" *** Late-Set Options *** "

set colorcolumn=80
highlight ColorColumn ctermbg=darkgray
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker
set foldlevel=99
set showcmd
set incsearch
set number
execute 'set dictionary=' . g:NeovimConfigurationDirectory . '/dictionary/en_US.txt'
execute 'set thesaurus=' . g:NeovimConfigurationDirectory . '/thesaurus/en_US.txt'
set nowrap
set spell
set iskeyword=@,48-57,_,192-255
" Session options to save on request
set ssop-=options               " Don't mess with options/plugins loaded!

" Set Colorscheme
"colorscheme base16-monokai
"colorscheme desert
"colorscheme Monokai
"colorscheme solarized
"colorscheme bmichaelsen
colorscheme luna
"colorscheme CodeFactoryv3
"colorscheme Chasing_Logic

" vim: set ft=vim: "

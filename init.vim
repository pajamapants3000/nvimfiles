" ${XDG_CONFIG_HOME}/nvim/init.vim
"
" Neovim configuration file

" **************************************************************************** "

" *** Definitions *** "
let g:NeovimConfigurationDirectory = '~/.config/nvim'
let g:ExtendDirectory = g:NeovimConfigurationDirectory.'/extend'

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
let g:filetype_aliases['ts']          = 'typescript'
let g:filetype_aliases['vbs']         = 'vbs'
let g:filetype_aliases['vb']          = 'vb'
let g:filetype_aliases['xaml']        = 'xaml'
let g:filetype_aliases['sharp']       = 'cs'
let g:filetype_aliases['razor']       = 'cshtml'
let g:filetype_aliases['razorvb']     = 'vbhtml'

let mapleader = '\'
let maplocalleader = '`'

" Additional sources
exe 'source '.g:NeovimConfigurationDirectory.'/kde-devel-vim.vim'

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
call plug#begin(g:ExtendDirectory)

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'fholgado/minibufexpl.vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'install.sh',
    \ }

" (Optional) Multi-entry selection UI. Run install script in repo
Plug 'junegunn/fzf'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'tmhedberg/matchit'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'juneedahamed/vc.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'embear/vim-localvimrc'
Plug 'valloric/matchtagalways'

" * Revision Control * "
Plug 'tpope/vim-fugitive'

" * Syntax Highlighting * "
Plug 'vim-jp/vim-cpp'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'OrangeT/vim-csharp'
Plug 'yuratomo/dotnet-complete'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/vbnet.vim'
Plug 'vim-scripts/aspnet.vim'
Plug 'sirtaj/vim-openscad'
Plug 'PProvost/vim-ps1'
Plug 'vim-scripts/fitnesse.vim'

" * Additional Language Support * "
"Plug 'pajamapants3000/nvim-typescript', {'do': './install.sh'}
Plug 'sukima/xmledit'
Plug 'derekwyatt/vim-fswitch'

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
Plug 'w0ng/vim-hybrid'
Plug 'sk1418/last256'

" * More * "
Plug 'pajamapants3000/vimwiki'

call plug#end()

" *** Plugin Configurations *** "
" * fholgado/minibufexpl.vim * "
let g:miniBufExplMaxSize = 2

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

" * Shougo/neosnippet.vim * "

imap j<Tab>     <Plug>(neosnippet_expand)
smap j<Tab>     <Plug>(neosnippet_expand)
xmap j<Tab>     <Plug>(neosnippet_expand_target)
imap <C-j>     <Plug>(neosnippet_jump)
smap <C-j>     <Plug>(neosnippet_jump)
let g:neosnippet#snippets_directory = g:NeovimConfigurationDirectory.'/snippets'

" SuperTab like snippets' behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Expand the completed snippet trigger by <CR>.
imap <expr><CR>
\ (pumvisible() && neosnippet#expandable()) ?
\ "\<Plug>(neosnippet_expand)" : "\<CR>"


" * 'valloric/matchtagalways'
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'rc' : 1,
    \}

" * autozimu/LanguageClient-neovim * "
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'go': ['go-langserver'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'python': ['pyls'],
    \ }
"    \ 'lua': ['lua-lsp'],
"    \ 'sh': ['bash-language-server', 'start'],

let g:LanguageClient_hasSnippetSupport = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" * Shougo/deoplete.nvim * "
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = 'python3'
let g:python_host_prog = 'python'
"let g:python3_host_prog = "C:/Python36/python.exe"
"let g:python_host_prog = "C:/Python27/python.exe"

" * scrooloose/syntastic * "
" NOTE: keeping this active for files that don't have LanguageClient support
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = []
let g:syntastic_c_checkers = []
" These options are valid if using syntastic for C/C++
"+ currently using LanguageClient instead, rendering syntastic redundant
"let g:syntastic_cpp_checkers = ["clang_check"]
"let g:syntastic_c_checkers = ["clang_check"]
"let g:syntastic_cpp_compiler_options = ' -std=c++14 -fPIC'
"let g:syntastic_cpp_clang_check_post_args = ""
" Using this to ensure no C/C++ auto-checking
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["c", "cpp"] }

" * pajamapants3000/vimwiki * "
" main wiki
let wiki = {}
let wiki.auto_export = 1
let wiki.diary_index = 'index'
let wiki.auto_toc = 1
let wiki.nested_syntaxes = g:filetype_aliases
let wiki.path = '~/vimwiki'
let wiki.path_html = wiki.path . '/html'

" Project wikis - for keeping project wiki with source code repository
" Project TimeIn
let wiki_project_timein = copy(wiki)
let wiki_project_timein.path = 
    \ substitute($WORKSPACE, "\\", "/", "g") . '/TimeIn/wiki/'
let wiki_project_timein.path_html = wiki_project_timein.path . '/html/'
let wiki_project_timein.template_path = wiki_project_timein.path . '/templates/'
" Project FinancialPanther
let wiki_project_financialpanther = copy(wiki_project_timein)
let wiki_project_financialpanther.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/FinancialPanther/wiki/'
let wiki_project_timein.path_html = wiki_project_financialpanther.path . '/html/'
" Project RustBook (working through The Rust Programming Language)
let wiki_RustBook = copy(wiki)
let wiki_RustBook.path = 
    \ substitute($WORKSPACE, "\\", "/", "g") . '/Rust/TheBook/wiki/'
let wiki_RustBook.path_html = wiki_RustBook.path . '/html/'
let wiki_RustBook.template_path = wiki_RustBook.path . '/templates/'

" Experiment: an attempt to write acceptance tests using vimwiki
let wiki_fitnesse = copy(wiki)
let wiki_fitnesse.path = 'C:/Fitnesse/FitnesseRoot/'
let wiki_fitnesse.syntax = 'fitnesse'

" plugin options
let g:vimwiki_folding = 'expr'
let g:vimwiki_list = [wiki,
    \ wiki_project_timein,
    \ wiki_project_financialpanther,
    \ wiki_fitnesse,
    \ wiki_RustBook]
let g:vimwiki_hl_headers = 1
let g:vimwiki_use_calendar = 1
let g:vimwiki_html_header_numbering = 0

" * tpope/vim-surround * "
" NOTE: for visual-mode surrounding, simply type 'S' then the surround character
nmap `` ysiw`
nmap (( ysiw(
nmap )) ysiw)
nmap [[ ysiw[
nmap ]] ysiw]
nmap {{ ysiw{
nmap }} ysiw}

" * 'sukima/xmledit'
nnoremap <leader>% :MtaJumpToOtherTag<cr>
let xml_jump_string = "`"

" * 'derekwyatt/vim-fswitch'
" See autocommands
nmap <silent> <F4>       :FSHere<cr>
nmap <silent> <Leader>cl :FSRight<cr>
nmap <silent> <Leader>cL :FSSplitRight<cr>
nmap <silent> <Leader>ch :FSLeft<cr>
nmap <silent> <Leader>cH :FSSplitLeft<cr>
nmap <silent> <Leader>ck :FSAbove<cr>
nmap <silent> <Leader>cK :FSSplitAbove<cr>
nmap <silent> <Leader>cj :FSBelow<cr>
nmap <silent> <Leader>cJ :FSSplitBelow<cr>
"

" *** Mappings *** "
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

" Quick folder jumps
nnoremap <Leader>dh :<c-u>cd ~<cr>
nnoremap <Leader>dr :<c-u>cd ~/source/repos<cr>
exe 'nnoremap <Leader>dw :<c-u>cd ' .
    \ substitute($WORKSPACE, "\\", "/", "g") . '<cr>'

" vimwiki-like jumping around buffers
nnoremap <BS> :<c-u>MBEbp<CR>
nnoremap <Space> :<c-u>MBEbn<CR>

" easier buffer switching
nnoremap \b :<c-u>exe v:count . "b"<cr>

" working with tabs (what about gt/gT?)
inoremap <c-tab> <c-o>:tabn<cr>
nnoremap <c-tab> :<c-u>tabn<cr>
inoremap <c-s-tab> <c-o>:tabp<cr>
nnoremap <c-s-tab> :<c-u>tabp<cr>
nnoremap <c-n> :<c-u>tabnew<cr>
nnoremap <c-q> :<c-u>tabclose<cr>

" arrow keys are redundant, so use them for something else - changing window focus
nnoremap <Up> <c-w><c-k>
nnoremap <Down> <c-w><c-j>
nnoremap <Left> <c-w><c-h>
nnoremap <Right> <c-w><c-l>

" delete carriage returns (I think) from line endings in current buffer
nnoremap \\<Enter> :<c-u>%s/$//

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
    " C/C++
    au! BufEnter *.c let b:fswitchdst = 'h'
                \ | let b:fswitchlocs = './,../include,reg:/src/include/'
                \ | setf c
    au! BufEnter *.c{pp,c,++,xx},*.C let b:fswitchdst = 'hpp,hh,h++,hxx,H,h'
                \ | let b:fswitchlocs = './,../include,reg:/src/include/'
                \ | setf cpp
    au! BufEnter *.h let b:fswitchdst = 'cpp,cc,c++,cxx,C,c'
                \ | let b:fswitchlocs = './,../src,../source,reg:/include/src/'
                \ | setf c
    au! BufEnter *.hpp let b:fswitchdst = 'cpp,cc,c++,cxx,C'
                \ | let b:fswitchlocs = './,../src,../source,reg:/include/src/'
                \ | setf cpp
    " XAML
    au BufNewFile,BufRead,BufEnter *.xaml       setf xml
    au BufNewFile,BufRead,BufEnter *.xaml       setl omnifunc=xaml#complete
    " Rust
    au BufNewFile,BufRead,BufEnter *.rs{,t}        setf rust
    " HTML
    au BufNewFile,BufRead,BufEnter *.htm{,l}    setf html
    " RC
    au BufNewFile,BufRead,BufEnter *.rc       setf xml

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

" VimWiki - prevent buflisted
    au BufNewFile,BufRead,BufEnter *.wiki       set nobuflisted

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
set viminfo=%,!,'50,\"100,:100
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

" ${XDG_CONFIG_HOME}/nvim/init.vim (linux)
" ${LOCALAPPDATA}/nvim/init.vim (windows)
"
" Neovim configuration file

" **************************************************************************** "

" *** Definitions *** "
if has('win32')
    let g:ConfigurationDirectory = $LOCALAPPDATA
    let g:Terminal = 'pwsh'
else
    let g:ConfigurationDirectory = $XDG_CONFIG_HOME
    let g:Terminal = 'bash'
endif
let g:NeovimConfigurationDirectory = g:ConfigurationDirectory.'/nvim'
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
"exe 'source '.g:NeovimConfigurationDirectory.'/kde-devel-vim.vim'

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

if has('win32')
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'powershell $errorActionPreference=''Stop''; Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process; .\install.ps1',
        \ }
else
    plug 'autozimu/languageclient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'install.sh',
        \ }
endif

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
Plug 'tpope/vim-commentary'
Plug 'chrisbra/recover.vim'

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
if has('win32')
    Plug 'pajamapants3000/nvim-typescript', {'do': './install.ps1'}
else
    Plug 'pajamapants3000/nvim-typescript', {'do': './install.sh'}
endif

Plug 'mattn/emmet-vim'
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

" * embear/vim-localvimrc * "
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 1

" * autozimu/LanguageClient-neovim * "
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'go': ['go-langserver'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'python': ['pyls'],
    \ }
    "\ 'rust': ['rustup', 'run', 'stable', 'rls'],
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
if has('win32')
    let g:python3_host_prog = $PROGRAMDATA.'/Anaconda3/python.exe'
    let g:python_host_prog = 'C:/Python27/python.exe'
else
    let g:python3_host_prog = 'python3'
    let g:python_host_prog = 'python'
endif

" * scrooloose/syntastic * "
" NOTE: keeping this active for files that don't have LanguageClient support
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_wq = 0
" These options are valid if using syntastic for C/C++
"+ currently using LanguageClient instead, rendering syntastic redundant
"let g:syntastic_cpp_checkers = ["clang_check"]
"let g:syntastic_c_checkers = ["clang_check"]
"let g:syntastic_cpp_compiler_options = ' -std=c++14 -fPIC'
"let g:syntastic_cpp_clang_check_post_args = ''
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" * pajamapants3000/vimwiki * "
" main wiki (wiki #1 aka wiki0)
let wiki = {}
let wiki.auto_export = 1
let wiki.diary_index = 'index'
let wiki.auto_toc = 1
let wiki.nested_syntaxes = g:filetype_aliases
let wiki.path = '~/vimwiki'
let wiki.path_html = wiki.path . '/html'

" Project wikis - for keeping project wiki with source code repository
" Project TimeIn (wiki #2 aka wiki1)
let wiki_project_timein = copy(wiki)
let wiki_project_timein.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/TimeIn/wiki/'
let wiki_project_timein.path_html = wiki_project_timein.path . '/html/'
let wiki_project_timein.template_path = wiki_project_timein.path . '/templates/'
" Project FinancialPanther (wiki #3 aka wiki2)
let wiki_project_financialpanther = copy(wiki_project_timein)
let wiki_project_financialpanther.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/FinancialPanther/wiki/'
let wiki_project_timein.path_html = wiki_project_financialpanther.path . '/html/'
" Project RustBook (working through The Rust Programming Language) (wiki #5 aka wiki4)
let wiki_RustBook = copy(wiki)
let wiki_RustBook.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/Rust/TheBook/wiki/'
let wiki_RustBook.path_html = wiki_RustBook.path . '/html/'
let wiki_RustBook.template_path = wiki_RustBook.path . '/templates/'
" Project TheLibrary (wiki #6 aka wiki5)
let wiki_project_thelibrary = copy(wiki)
let wiki_project_thelibrary.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/TheLibrary/wiki/'
let wiki_project_thelibrary.path_html = wiki_project_thelibrary.path . '/html/'
let wiki_project_thelibrary.template_path = wiki_project_thelibrary.path . '/templates/'
" Project soup (wiki #7 aka wiki6)
let wiki_project_soup = copy(wiki)
let wiki_project_soup.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/soup.wiki/'
let wiki_project_soup.path_html = wiki_project_soup.path . '/html/'
let wiki_project_soup.template_path = wiki_project_soup.path . '/templates/'
" Project clutter (wiki #8 aka wiki7)
let wiki_project_clutter = copy(wiki)
let wiki_project_clutter.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/clutter.wiki/'
let wiki_project_clutter.path_html = wiki_project_clutter.path . '/html/'
let wiki_project_clutter.template_path = wiki_project_clutter.path . '/templates/'
" Project practice (wiki #9 aka wiki8)
let wiki_project_practice = copy(wiki)
let wiki_project_practice.path =
    \ substitute($WORKSPACE, "\\", "/", "g") . '/Practice.wiki/'
let wiki_project_practice.path_html = wiki_project_practice.path . '/html/'
let wiki_project_practice.template_path = wiki_project_practice.path . '/templates/'

" Experiment: an attempt to write acceptance tests using vimwiki (wiki #4 aka wiki3)
let wiki_fitnesse = copy(wiki)
let wiki_fitnesse.path = 'C:/Fitnesse/FitnesseRoot/'
let wiki_fitnesse.syntax = 'fitnesse'

" plugin options
let g:vimwiki_folding = 'expr'
let g:vimwiki_list = [wiki,
    \ wiki_project_timein,
    \ wiki_project_financialpanther,
    \ wiki_fitnesse,
    \ wiki_RustBook,
    \ wiki_project_thelibrary,
    \ wiki_project_soup,
    \ wiki_project_clutter,
    \ wiki_project_practice]
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

" * mattn/emmet-vim *
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {'html': {'default_attributes': {}, 'expandos': {}}}
let g:user_emmet_settings.html.default_attributes.nav = {}
let g:user_emmet_settings.html.default_attributes.nav.role = 'navigation'
let g:user_emmet_settings.html.expandos.divc = 'div.container>'
let g:user_emmet_settings.html.expandos.divr = 'div.row>'
let g:user_emmet_settings.html.expandos.divd1 = 'div.col-md-1>'
let g:user_emmet_settings.html.expandos.divd2 = 'div.col-md-2>'
let g:user_emmet_settings.html.expandos.divd3 = 'div.col-md-3>'
let g:user_emmet_settings.html.expandos.divd4 = 'div.col-md-4>'
let g:user_emmet_settings.html.expandos.divd5 = 'div.col-md-5>'
let g:user_emmet_settings.html.expandos.divd6 = 'div.col-md-6>'
let g:user_emmet_settings.html.expandos.divd7 = 'div.col-md-7>'
let g:user_emmet_settings.html.expandos.divd8 = 'div.col-md-8>'
let g:user_emmet_settings.html.expandos.divd9 = 'div.col-md-9>'
let g:user_emmet_settings.html.expandos.divd10 = 'div.col-md-10>'
let g:user_emmet_settings.html.expandos.divd11 = 'div.col-md-11>'
let g:user_emmet_settings.html.expandos.divd12 = 'div.col-md-12>'
let g:user_emmet_settings.html.expandos.nav = 'nav.navbar.navbar-light.bg-light.'
            \ .'fixed-top>a.navbar-brand[href=#]>i.fa.fa-user>'

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
nnoremap <BS> :<c-u>MBEbb<CR>
nnoremap <Space> :<c-u>MBEbf<CR>

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

" auto-close using help from (possibly language-specific) snippets
inoremap {<cr> {}<c-r>=neosnippet#expand('{}')<cr>
inoremap {<space> {-}<c-r>=neosnippet#expand('{-}')<cr>
inoremap [<cr> []<c-r>=neosnippet#expand('[]')<cr>
inoremap [<space> [-]<c-r>=neosnippet#expand('[-]')<cr>
inoremap (<cr> ()<c-r>=neosnippet#expand('()')<cr>
inoremap (<space> (-)<c-r>=neosnippet#expand('(-)')<cr>
" auto-close quotations
inoremap <expr> " strpart(getline("."), col(".") - 1, 1) == '"'
            \ ? "\<Right>"
            \ : "\"\"\<Left>"


" terminal mappings
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>tt :<c-u>exe 'below new term://'.g:Terminal<CR><s-a>

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
    au! BufEnter *.html let b:fswitchdst = 'ts,js'
                \ | let b:fswitchlocs = './'
                \ | setf html
    " XAML
    au BufNewFile,BufRead,BufEnter *.xaml       setf xml
    au BufNewFile,BufRead,BufEnter *.xaml       setl omnifunc=xaml#complete
    " Rust
    au BufNewFile,BufRead,BufEnter *.rs{,t}        setf rust
    " HTML
    au BufNewFile,BufRead,BufEnter *.htm{,l} let b:fswitchdst = 'ts,js'
                \ | let b:fswitchlocs = './'
                \ | setf html
    au FileType html,css EmmetInstall

    " TypeScript
    au BufEnter *.ts let b:fswitchdst = 'html'
                \ | let b:fswitchlocs = './'
    " JavaScript
    au BufEnter *.js let b:fswitchdst = 'html'
                \ | let b:fswitchlocs = './'
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

" Load default snippets
    au BufNewFile,BufRead,BufEnter *
            \ :exe 'NeoSnippetSource '.g:neosnippet#snippets_directory.'/all.snip'
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

if has('win32')
    set shell=pwsh.exe
    set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
    set shellpipe=|
    set shellredir=>
else
endif

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

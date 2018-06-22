" $XDG_CONFIG_HOME/nvim/init.vim
"
" Neovim configuration file
"

" **************************************************************************** "
" Get important paths for easy use later
"+g:CloudConfig
"+g:PlatformIndependentHome
"+g:PlatformIndependentXdgHome
"+g:LocalConfig
"+g:LocalVimConfig
"+g:VundleFolder

" Get the location of this script
let g:CloudConfig = resolve(expand('<sfile>:p:h'))

" Determine proper locations of home, vimfiles, and nvimfiles
let g:PlatformIndependentHome =
        \ has('win32') ? substitute($USERPROFILE, "\\", "/", "g") : $HOME
if strlen($XDG_CONFIG_HOME) == 0
    let g:PlatformIndependentXdgHome = g:PlatformIndependentHome
else
    let g:PlatformIndependentXdgHome = $XDG_CONFIG_HOME
endif       
let g:PlatformIndependentVimFolder =
        \ has('win32') ? 'vimfiles' : '.vim'
let g:PlatformIndependentNeovimFolder =
        \ has('win32') ? 'nvim' : '.nvim'

" Now add the usual system-specific user configuration
let g:LocalConfig =
      \ g:PlatformIndependentXdgHome . '/' . g:PlatformIndependentNeovimFolder
let g:LocalVimConfig =
      \ g:PlatformIndependentHome . '/' . g:PlatformIndependentVimFolder

let g:VundleFolder = g:LocalVimConfig . '/bundle'
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "
" Set runtimepaths
"execute "set runtimepath^=" . g:CloudConfig
execute "set runtimepath^=" . g:LocalConfig . "runtimepath+=" . g:LocalConfig.'/after'
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "
" Link up to existing vim configuration
let g:config_type='neovim'
let g:vim_config_file='vimrc'
let &packpath = &runtimepath
execute "source " . g:LocalVimConfig . '/' . g:vim_config_file
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "

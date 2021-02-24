" NeoVIM Configuration File
" Compiled by ccxex29
" Version 2020/12

"Import VIM Plugins
let runtimepath = fullnvimpath . "/.vim_runtime"
execute "set runtimepath+=" . runtimepath

" Unused Powerline
"source ./powerline_local.vim
"source ./unused.vim

" ======================================================================================

" Color Settings
source ./color_tweak.vim

" Line Numbering
source ./line-numbering.vim

" Auto expand brackets

" Remove default vim mappings I don't personally like
source ./mod-default-bindings.vim

" VIM Plug
source ./plug.vim

" CoC
source ./coc.vim

" NERD
source ./postplugin/nerd.vim

" CHAD
source ./postplugin/chad.vim

" Code of Completion (CoC) Config
source .vim/coc.vim

" Final Themeing
source ./postplugin/themeing.vim

" Status Line Tweaks
source ./vanilla-behave.vim

" Italic Comments
source ./italic-comments.vim

" highlight CursorLineNr guifg=#ffffff guibg=#000000 gui=NONE

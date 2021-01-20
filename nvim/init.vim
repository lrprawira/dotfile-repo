" NeoVIM Configuration
" Made by ccxex29
" Version 2020/12

" Specify Python Binary Manually if needed
"let g:python_host_prog = '/usr/bin/python2'
"let g:python3_host_prog = '/usr/bin/python3'
"
" Connect to Vim Default Runtime Directory
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ===============================================

" Preserve User Path Before Initialisation
redir => initialpath
silent pwd
redir END

" Start Configuration
let homepath = '/home/ccxex29/'
let nvimcfg = '.config/nvim'
let fullnvimpath = stdpath('config')
execute "cd" . fullnvimpath
source ./main.vim

" Return to User's initial path
cd `=initialpath`


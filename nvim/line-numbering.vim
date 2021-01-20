" NeoVIM Configuration
" Made by ccxex29
" Version 2020/12

" Enable Line Numbering
set number relativenumber
set cursorline

" Remove Relative Line Number on Leave
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

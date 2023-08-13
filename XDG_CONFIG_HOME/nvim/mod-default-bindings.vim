" NeoVIM Configuration File
" Compiled by ccxex29
" Version 2020/12

" No arrow keys for u >:D
for keys in ['<Up>', '<Down>', '<Left>', '<Right>', '<PageUp>', '<PageDown>']
  for remapcmds in ['nnoremap', 'vnoremap'] 
    exec remapcmds keys ':echo "Use <h>,<j>,<k>,<l> !" <CR>'
  endfor
endfor
" No easy escape for u >:D
noremap ZZ :echo "Do not exit this way!" <CR>
noremap <C-c> :echo "Do not exit this way!" <CR>

" Force to use Control-J and Control-K or Control-N and Control-P to Navigate
" in Command-Line Mode
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

cnoremap <Up> <Nop>
cnoremap <Down> <Nop>

" Easy Terminal Mode
nmap <silent><C-t> :edit term://zsh<CR>


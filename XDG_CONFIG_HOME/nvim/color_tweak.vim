" NeoVIM Configuration
" Made by ccxex29
" Version 2021/02

" Base16 Vim Color Settings

" True Color Support Only
" =======================
" This conflicts with tmux (+byobu and the likes)
" Only use if really needed.

"set termguicolors


if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

let base16colorspace=256


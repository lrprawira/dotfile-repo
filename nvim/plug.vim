" NeoVIM Configuration File
" Compiled by ccxex29
" Version 2020/12

call plug#begin(fullnvimpath . '/.vim/plugged')

" NERDTree Plugin
Plug 'preservim/nerdtree'

" Base16 ColorScheme
Plug 'chriskempson/base16-vim'

" LightLine Mode
Plug 'itchyny/lightline.vim'

" Base16 LightLine
Plug 'mike-hearn/base16-vim-lightline'

" Last Place
Plug 'farmergreg/vim-lastplace'

" Vim Surround
Plug 'tpope/vim-surround'

" Vim Multiple Cursor

" FZF Fuzzy Finder
Plug 'junegunn/fzf.vim'

" CoC Suggestion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Comment Toggler
Plug 'preservim/nerdcommenter'

" End VIM Plug
call plug#end()

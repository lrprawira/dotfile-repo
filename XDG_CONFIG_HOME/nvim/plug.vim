" NeoVIM Configuration File
" Compiled by ccxex29
" Version 2020/12

call plug#begin(fullnvimpath . '/.vim/plugged')

" NERDTree Plugin
"Plug 'preservim/nerdtree'

" CHADTree - File Manager
Plug 'ms-jpq/chadtree', 
			\ { 
			\ 	'branch': 'chad',
			\ 	'do': 'python3 -m chadtree deps'
			\ }

" Base16 ColorScheme
Plug 'chriskempson/base16-vim'

" LightLine Mode
Plug 'itchyny/lightline.vim'

" Base16 LightLine
Plug 'mike-hearn/base16-vim-lightline'

" Last Place
Plug 'farmergreg/vim-lastplace'

" Polyglot Better Syntax Highlighting
Plug 'sheerun/vim-polyglot'

" Vim Surround
Plug 'tpope/vim-surround'

" Vim Multiple Cursor

" FZF Fuzzy Finder
Plug 'junegunn/fzf.vim'

" CoC Suggestion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Comment Toggler
Plug 'preservim/nerdcommenter'

" Dev Icons
Plug 'ryanoasis/vim-devicons'

" End VIM Plug
call plug#end()

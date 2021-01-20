" NeoVIM Configuration File
" Compiled by ccxex29
" Version 2020/12

colorscheme base16-materia
let g:lightline = {
	\ 'colorscheme': 'base16_materia',
	\ 'mode-map': {
		\	's': 'SELECT',
		\ },
	\ 'active': {
		\	'left': [ 
		\ 		[ 'mode', 'paste' ],	
		\ 		[ 'readonly', 'filename', 'modified', 'cocstatus' ] 
		\ 	]
		\ },
	\ 'component_function': {
		\ 'cocstatus': 'coc#status'
	\ 	}
	\ }


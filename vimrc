call plug#begin('~/.vim/plugged') 
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'Shougo/neocomplete.vim'
call plug#end()

" タブ幅
set tabstop=4
set softtabstop=4
set shiftwidth=4

augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


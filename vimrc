call plug#begin('~/.vim/plugged') 
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'Shougo/neocomplete.vim'
Plug 'pocke/dicts'
call plug#end()

set cursorline
set scrolloff=5

let g:neocomplete#enable_at_startup = 1
let s:neco_dicts_dir = $HOME . '/.vim/plugged/dicts'
if isdirectory(s:neco_dicts_dir)
	let g:neocomplete#sources#dictionary#dictionaries = {
		\   'ruby': s:neco_dicts_dir . '/ruby.dict',
		\   'javascript': s:neco_dicts_dir . '/jquery.dict',
		\ }
endif

" タブ幅
set tabstop=4
set softtabstop=4
set shiftwidth=4
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" 不可視文字を表示
set list
" 不可視文字を表示の詳細設定
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 全角スペースの可視化
if has("syntax")
	syntax on

	" PODバグ対策
	syn sync fromstart

	function! ActivateInvisibleIndicator()
		syntax match InvisibleJISX0208Space "　" display containedin=ALL
		highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
	endfunction

	augroup invisible
		autocmd! invisible
		autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
	augroup END
endif

" 行末までヤンク
nnoremap Y y$

" 長い行でも表示しきる
set display=lastline

" 対応カッコと強調表示時間
set showmatch
set matchtime=1

" 補完メニュー行数
"set pumheight=10

set swapfile
" スワップ作成済みなら読み取り専用で開く
augroup swapchoice-readonly
	autocmd!
	autocmd SwapExists * let v:swapchoice = 'o'
augroup END

" バックアップを取らない
set nobackup


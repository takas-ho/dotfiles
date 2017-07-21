if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/plugged/vim-plug
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'rcmdnk/vim-markdown', { 'for': ['markdown']}
Plug 'rhysd/vim-gfm-syntax', { 'for': ['markdown']}
Plug 'glidenote/memolist.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}

if 16 <= &t_Co
	Plug 'bling/vim-airline'
	let g:airline#extensions#tabline#enabled = 1
endif

" colorscheme
Plug 'tomasr/molokai'
Plug 'keith/parsec.vim'

call plug#end()

filetype plugin indent on

" 構文ハイライト表示
syntax enable
" 行番号表示
set number

set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cursorline
	autocmd!
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END

set scrolloff=5

" Shift-jis対応
set fileencodings=utf-8,sjis

colorscheme industry

" コード補完
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
set listchars=tab:\▸\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 全角スペースの可視化
if has("syntax")
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

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

" 上下移動「論理行」「表示行」を入れ替え
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" 行末までヤンク
nnoremap Y y$
" 日時入力の補助
inoremap <expr> ,df  strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd  strftime('%Y-%m-%d')
inoremap <expr> ,dt  strftime('%H:%M:%S')
" カーソル下のキーワードをヘルプ表示
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>
" 最後に変更したテキストを選択
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" 長い行でも表示しきる
set display=lastline

" 対応カッコと強調表示時間
set showmatch
set matchtime=1

" 補完メニュー行数
"set pumheight=10

" make dir
function! s:MakeDirIfNotExist(directory)
	if !isdirectory(expand(a:directory))
		call mkdir(expand(a:directory),"p")
	endif
endfunction

set swapfile
" スワップ作成済みなら読み取り専用で開く
augroup swapchoice-readonly
	autocmd!
	autocmd SwapExists * let v:swapchoice = 'o'
augroup END
set directory=$HOME/.tmp/vim/swap
call s:MakeDirIfNotExist(&directory)

"File
set hidden      "ファイル変更中でも他のファイルを開けるようにする
set autoread    "ファイル内容が変更されると自動読み込みする

"	backup
set backup
set backupdir=$HOME/.tmp/vim/backup
call s:MakeDirIfNotExist(&backupdir)

"	undo
if has('persistent_undo')
	set undolevels=2000
	set undofile
	set undodir=$HOME/.tmp/vim/undo
	call s:MakeDirIfNotExist(&undodir)
endif

set helplang=ja,en

let mapleader = "\<Space>"

" vimgrep結果をcopenせずに開く
autocmd QuickfixCmdPost * copen

nnoremap <Leader>ee :<C-u>NERDTreeToggle<CR>

" memolist
nnoremap <Leader>mn  :<C-u>MemoNew<CR>
nnoremap <Leader>ml  :<C-u>MemoList<CR>
nnoremap <Leader>mg  :<C-u>MemoGrep<CR>
let g:memolist_memo_suffix = "md"
let g:memolist_qfixgrep = 1
let g:memolist_ex_cmd = 'NERDTree'

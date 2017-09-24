if &term == 'win32'
	set termencoding=cp932
else
	set termencoding=utf-8
endif
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932

scriptencoding=utf-8

if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/plugged/vim-plug
endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin  = has('win32unix')
let s:is_gui     = has('gui_running')
let s:is_unix    = has('unix')
let s:is_mac     = has('mac')
if (s:is_unix || s:is_cygwin) && &term =~# '^xterm' && &t_Co < 256
	set t_Co=256
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'
Plug 'Shougo/neocomplete.vim'
Plug 'rcmdnk/vim-markdown', { 'for': ['markdown']}
Plug 'rhysd/vim-gfm-syntax', { 'for': ['markdown']}
Plug 'glidenote/memolist.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'ctrlpvim/ctrlp.vim'

Plug 'cocopon/vaffle.vim'
let g:vaffle_show_hidden_files = 1

if s:is_gui
	Plug 'bling/vim-airline'
elseif 16 <= &t_Co
	Plug 'bling/vim-airline'
	set showtabline=2					" タブを常に表示
endif

Plug 'scrooloose/syntastic'

" edit
Plug 'SirVer/ultisnips'

" lang
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

" colorscheme
Plug 'tomasr/molokai'
Plug 'keith/parsec.vim'

call plug#end()

filetype plugin indent on

" 構文ハイライト表示
syntax enable
" 行番号表示
set number

if s:is_windows || s:is_cygwin
	if &t_Co < 256
		"colorscheme industry
		colorscheme pablo
	else
		colorscheme molokai
	endif
else
	colorscheme industry
endif

set cursorline				" 現在の行を強調表示
" カレントウィンドウにのみ罫線を引く
augroup cursorline
	autocmd!
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END

set backspace=start,eol,indent		" Backspaceで文字の削除とeol,indentも削除可能に
set whichwrap=b,s,h,l,[,],<,>,~		" カーソルキーでeolをまたげるように
set mouse=							" ターミナルごとに動作が異なるらしいマウス連動はしない
set laststatus=2					" ステータス行を常に表示
set scrolloff=5						" カーソルの上端または下端に最低5行は表示

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
augroup myFIleType
	autocmd!
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autowrite
augroup END
augroup goFileType
	autocmd!
	autocmd FileType go noremap <C-n>		:<C-u>cnext<CR>
	autocmd FileType go noremap <C-m>		:<C-u>cprevious<CR>
	autocmd FileType go nnoremap <leader>a	:<C-u>cclose<CR>
	autocmd FileType go nnoremap <leader>b	:<C-u>call <SID>build_go_files()<CR>
	autocmd FileType go nmap <leader>r		<Plug>(go-run)
	autocmd FileType go nmap <leader>t		<Plug>(go-test)
	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	let g:go_highlight_structs = 1
	let g:go_highlight_build_constraints = 1
	let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
	let g:syntastic_go_checkers = ['go', 'golint']
augroup END
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

if s:is_cygwin
	set shell=bash		" デフォルトのままだとcmd.exe
endif

" 見た目

" markdown
hi link htmlItalic LineNr
hi link htmlBold WarningMsg
hi link htmlBoldItalic ErrorMsg

set smartindent							" インデントはスマートインデント
set visualbell							" ビープ音を可視化
set showmatch							" 対応する括弧表示
set matchtime=1							" 対応カッコ強調表示時間
source $VIMRUNTIME/macros/matchit.vim	" Vimの「%」を拡張する
set display=lastline					" 長い行でも表示しきる

" ステータスラインを常に表示
set laststatus=2

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

nnoremap <Esc><Esc> :nohlsearch<CR><Esc>	" ESC連打でハイライト解除
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
set nofixeol	" ファイル末尾に改行が追加されるのを抑止

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

" 標準だとコマンド履歴のフィルタリングまではしないからするように
cnoremap <C-p>       <Up>
cnoremap <C-n>       <Down>

let g:mapleader = "\<Space>"

" Find merge conflict markers
nnoremap <leader>fc  /\v^[<\|=>]{7}( .*\|$)<CR>

cnoremap cd.         lcd %:p:h	" Change Working Directory to that of the current file
vnoremap .           :normal .<CR>	" Allow using the repeat operator with a visual selection

" Navigation for tabs
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabprev<CR>
nnoremap tk  :tabnext<CR>
nnoremap tl  :tablast<CR>
nnoremap tm  :tabm<Space>
nnoremap tn  :tabnew<CR>
nnoremap td  :tabclose<CR>

nnoremap tt  :tabnext<CR>

" vimgrep結果をcopenせずに開く
augroup quickfix-open
	autocmd!
	autocmd QuickfixCmdPost * copen
augroup END

nnoremap <Leader>ev  :<C-u>tabnew $MYVIMRC<CR>
nnoremap <Leader>sv  :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>ee  :<C-u>NERDTreeToggle<CR>

nnoremap <Leader>o   :CtrlP<CR>
nnoremap <Leader>w   :w<CR>
nmap     ,U          :set encoding=utf-8<CR>
nmap     ,E          :set encoding=euc-jp<CR>
nmap     ,S          :set encoding=cp932<CR>

" memolist
nnoremap <Leader>mn  :<C-u>MemoNew<CR>
nnoremap <Leader>ml  :<C-u>MemoList<CR>
nnoremap <Leader>mg  :<C-u>MemoGrep<CR>
let g:memolist_memo_suffix = "md"
let g:memolist_qfixgrep = 1
let g:memolist_ex_cmd = 'NERDTree'

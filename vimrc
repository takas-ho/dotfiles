if &term == 'win32'
	set termencoding=cp932
else
	set termencoding=utf-8
endif
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932

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
let s:is_cui     = !s:is_gui

if (s:is_unix || s:is_cygwin) && &term =~# '^xterm' && &t_Co < 256
	set t_Co=256
endif

silent! call plug#begin('~/.vim/plugged')

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-javascript', { 'for': ['javascript']}

Plug 'vim-jp/vimdoc-ja'
Plug 'glidenote/memolist.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'justinmk/vim-dirvish'
Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'			" キャッシュディレクトリ
let g:ctrlp_clear_cache_on_exit = 0						" キャッシュを終了時に削除しない
let g:ctrlp_lazy_update = 1								" 遅延再描画
let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml', 'package.json', '.gitignore']	" ルートパスと認識させるためのファイル
let g:ctrlp_max_height = 20								" CtrlPのウィンドウ最大高さ
" 無視するディレクトリ
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|_v\/(bin|obj)$|\v[\/](node_modules|build)$|\v[\/]_ReSharper\..*$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" markdown
Plug 'godlygeek/tabular', { 'for': ['markdown']}
Plug 'tyru/open-browser.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'aklt/plantuml-syntax'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'pocke/vim-textobj-markdown' " markdownのコードブロックをtextobj化

Plug 'thinca/vim-quickrun'

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_use_migemo = 1
Plug 'tpope/vim-unimpaired'

Plug 'cocopon/vaffle.vim'
let g:vaffle_show_hidden_files = 1

Plug 'tpope/vim-fugitive' | Plug 'gregsexton/gitv', { 'on': ['Gitv']}
let g:Gitv_OpenHorizontal = 1
let g:Gitv_DoNotMapCtrlKey = 1
let g:Gitv_TruncateCommitSubjects = 1

if s:is_gui
	Plug 'bling/vim-airline'
elseif 16 <= &t_Co
	Plug 'itchyny/lightline.vim'
	set showtabline=2					" タブを常に表示
endif

" filetype
Plug 'yuki2cb/vim-vbnet'

" edit
if !s:is_windows && !s:is_cygwin
	Plug 'SirVer/ultisnips'
endif

" javascript
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
Plug 'leshill/vim-json'

" lang

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
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

set backspace=start,eol,indent		" Backspaceで文字の削除とeol,indentも削除可能に
set whichwrap=b,s,h,l,[,],<,>,~		" カーソルキーでeolをまたげるように
set mouse=							" ターミナルごとに動作が異なるらしいマウス連動はしない
set laststatus=2					" ステータス行を常に表示
set scrolloff=5						" カーソルの上端または下端に最低5行は表示

" vim-lsp
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'javascript support using typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['javascript', 'javascript.jsx']
      \ })
endif

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
augroup myFileType
	autocmd!
	autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
	autocmd BufNewFile,BufRead *.vb set filetype=vbnet
	autocmd BufNewFile,BufRead *.ts set filetype=typescript
augroup END
augroup myFileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	autocmd filetype markdown setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	autocmd filetype typescript setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	autocmd BufNewFile,BufRead *.html,*.htm setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	autocmd BufNewFile,BufRead *.css,*.scss,*.sass setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	autocmd BufNewFile,BufRead *.js,*.json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	autocmd BufNewFile,BufRead *.vb setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autowrite
augroup END

if s:is_cygwin
	set shell=bash		" デフォルトのままだとcmd.exe
endif

" 見た目
"" 現在の列を強調表示
"set cursorcolumn

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
set foldlevel=99						" 折りたたまれるのを抑止

set wildmode=list:longest				" コマンドラインの補完
set nofixeol							" 自動改行は無効
set wildignore+=node_modules/**,.git/**	" vimgrepの無視設定

" Tab
" 不可視文字を可視化
set list
if &term == 'win32'
	set listchars=tab:>-,trail:･,precedes:<,extends:>
else
	set listchars=tab:\▸\ ,trail:▵,eol:↲,extends:»,precedes:«,nbsp:%
endif
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
" 行頭・行末移動も「論理行」「表示行」を入れ替え
noremap 0 g0
noremap g0 0
noremap ^ g^
noremap g^ ^
noremap $ g$
noremap g$ $
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
if s:is_windows
	set directory=$TMP/vim/swap
else
	set directory=$HOME/.tmp/vim/swap
endif
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

" x切り取りが、貼り付けされるのを回避
noremap x "_x

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

" easymotion
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)	
" migemo
map g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)


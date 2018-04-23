let s:is_windows = has('win16') || has('win32') || has('win64')
" display & information
set lines=60
set columns=200
if !s:is_windows
	set guioptions=c	" show no GUI components
	set guioptions-=T	" ツールバー非表示
endif
colorscheme desert
set background=dark

if has('gui_macvim')
    set showtabline=2	" タブを常に表示
    set transparency=5	" 透明度を指定
    set antialias
    set guifont=Osaka－等幅:h18
    set linespace=0
    silent! colorscheme parsec
endif
if has('kaoriya')
	set showtabline=2	" タブを常に表示
	autocmd GUIEnter * set transparency=240
	set guifont=MS_GOTHIC:h9
	set noundofile
	colorscheme parsec
endif
if !s:is_windows
	set imdisable	" IMを無効化
	set cursorline
endif
highlight CursorLine gui=underline guifg=NONE guibg=NONE

set visualbell t_vb= " ビープ音なし

set title    "編集中のファイル名を表示する
set ruler    "座標を表示する

nnoremap <Leader>eg  :<C-u>tabnew $MYGVIMRC<CR>
nnoremap <Leader>sg  :<C-u>source $MYGVIMRC<CR>

" display & information
set lines=60
set columns=128
set guioptions=c	" show no GUI components
set guioptions-=T	" ツールバー非表示
colorscheme desert
set background=dark

if has('gui_macvim')
    set showtabline=2	" タブを常に表示
    set transparency=5	" 透明度を指定
    set antialias
    set guifont=Monaco:h11
    silent! colorscheme parsec
endif
set cursorline
set imdisable	" IMを無効化

set visualbell t_vb= " ビープ音なし

set title    "編集中のファイル名を表示する
set ruler    "座標を表示する

nnoremap <Leader>eg  :<C-u>tabnew $MYGVIMRC<CR>
nnoremap <Leader>sg  :<C-u>source $MYGVIMRC<CR>

" display & information
set lines=55
set columns=128

if has('gui_macvim')
    set showtabline=2	" タブを常に表示
    set imdisable	" IMを無効化
    set transparency=5	" 透明度を指定
    set antialias
    set guifont=Monaco:h11
    colorscheme macvim
endif
set cursorline
"set transparency=5 " 透明度
set imdisable " IME OFF
set guioptions-=T " ツールバー非表示

set visualbell t_vb= " ビープ音なし

"Display
colorscheme desert
set background=dark

set title    "編集中のファイル名を表示する
set ruler    "座標を表示する
set laststatus=2    "ステータスラインを常に表示する


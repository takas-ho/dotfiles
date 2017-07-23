command! Debugstring call s:debugString()

function! s:debugString()
	echo "utf8 char=▸"
	echo "t_Co=" . &t_Co
	echo "term=" . &term
	echo "has('win32unix')=" . has('win32unix')
	echo "has('win32')=" . has('win32')
	echo "has('win16')=" . has('win16')
	echo "has('win64')=" . has('win64')
	echo "has('unix')=" . has('unix')
	echo "has('mac')=" . has('mac')
	echo "has('gui_running')=" . has('gui_running')
endfunction

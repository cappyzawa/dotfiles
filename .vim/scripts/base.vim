if !exists('g:env')
	finish
endif

function! s:echomsg(hl, msg) "{{{1
	execute 'echohl' a:hl
	try
		echomsg a:msg
	finally
		echohl None
	endtry
endfunction

function! Error(msg) abort "{{{1
	echohl ErrorMsg
	echo 'ERROR: ' . a:msg
	echohl None
	return g:false
endfunction

function! Warn(msg) abort "{{{1
	echohl WarningMsg
	echo 'WARNING: ' . a:msg
	echohl None
	return g:true
endfunction


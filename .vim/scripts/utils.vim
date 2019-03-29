if !exists('g:env')
  finish
endif

" Restore cursor position
if g:env.vimrc.restore_cursor_position == g:true
  function! s:restore_cursor_postion()
    if line("'\"") <= line("$")
      normal! g`"
      return 1
    endif
  endfunction
  augroup restore-cursor-position
    autocmd!
    autocmd BufWinEnter * call <SID>restore_cursor_postion()
  augroup END
endif

" Restore the buffer that has been deleted {{{1
let s:bufqueue = []
augroup buffer-queue-restore
  autocmd!
  "autocmd BufDelete * call <SID>buf_enqueue(expand('#'))
augroup END

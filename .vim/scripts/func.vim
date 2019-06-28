if !exists('g:env')
  finish
endif

function! OpenTerminal()
  let l:bufnr = bufnr('%')
  let l:winnr = winbufnr(l:bufnr)
  let l:wh = winheight(l:winnr)
  let l:ww = winwidth(l:winnr)
  let l:margin = 8
  wincmd ge
  call nvim_open_win(l:bufnr, v:true, {
          \   'height': l:wh - l:margin,
          \   'width': l:ww - l:margin * 2,
          \   'relative': 'editor',
          \   'focusable': v:true,
          \   'anchor': 'NW',
          \   'row': l:margin/2,
          \   'col': l:margin,
          \   'external': v:false,
        \})
  terminal
  startinsert
endfunction

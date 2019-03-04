if !exists('g:env')
	finish
endif

" Define mapleader
let g:mapleader = ','
let g:maplocalleader = ','

" Smart space mapping
nmap <Space> [Space]
xmap <Space> [Space]
nnoremap [Space] <Nop>
xnoremap [Space] <Nop>
noremap [Space]h ^
noremap [Space]l $


inoremap <C-h> <Backspace>
inoremap <C-d> <Delete>
cnoremap <C-k> <UP>
cnoremap <C-j> <DOWN>
cnoremap <C-l> <RIGHT>
cnoremap <C-h> <LEFT>
cnoremap <C-d> <DELETE>
cnoremap <C-p> <UP>
cnoremap <C-n> <DOWN>
cnoremap <C-f> <RIGHT>
cnoremap <C-b> <LEFT>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-n> <Up>
inoremap <C-p> <Down>
inoremap <C-m> <CR>

nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Must 
inoremap jj <ESC>
cnoremap <expr> j getcmdline() [getcmdops()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
vnoremap <C-j><C-j> <ESC>
onoremap jj <ESC>
inoremap j[Space] j
onoremap j[Space] j

nnoremap n nzz
nnoremap N Nzz
nnoremap S *zz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" View file information
nnoremap <C-g> 1<C-g>
" Write only when the buffer has been modified
nnoremap <silent><CR> :<C-u>silent update<CR>

" Type 'v', select end of line in visual mode
nnoremap v $h
" Make Y behave like other capitals
nnoremap Y y$
" expand path
cmap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <c-z> <c-r>=expand('%:p:r')<cr>
" Add a relative number toggle
nnoremap <silent> <Leader>r :<C-u>call <SID>toggle_option('relativenumber')<CR>
" Add a spell check toggle
nnoremap <silent> <Leader>s :<C-u>call <SID>toggle_option('spell')<CR>
" Tabs Increase
nnoremap <silent> ~ :let &tabstop = (&tabstop * 2 > 16) ? 2 : &tabstop * 2<CR>:echo 'tabstop:' &tabstop<CR>
" Toggle top/center/bottom
noremap <expr> zz (winline() == (winheight(0)+1)/ 2) ?  'zt' : (winline() == 1)? 'zb' : 'zz'
" Jump a next blank line
nnoremap <silent>W :<C-u>keepjumps normal! }<CR>
nnoremap <silent>B :<C-u>keepjumps normal! {<CR>
" Save word and exchange it under cursor
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
" Yank the entire file
nnoremap <Leader>y :<C-u>%y<CR>
nnoremap <Leader>Y :<C-u>%y<CR>

nnoremap <silent> <Leader>l :<C-u>call <SID>toggle_option('cursorline')<CR>
nnoremap <silent> <Leader>c :<C-u>call <SID>toggle_option('cursorcolumn')<CR>

" Swap jk for gjgk 
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

if g:env.vimrc.goback_to_eof2bof == g:true
    function! s:up(key)
        if line(".") == 1
            return ":call cursor(line('$'), col('.'))\<CR>"
        else
            return a:key
        endif
    endfunction
    function! s:down(key)
        if line(".") == line("$")
            return ":call cursor(1, col('.'))\<CR>"
        else
            return a:key
        endif
    endfunction
    nnoremap <expr><silent> k <SID>up("gk")
    nnoremap <expr><silent> j <SID>down("gj")
endif

" Buffers, windows, and tabpages 
if !g:plug.is_installed('vim-buftabs')
    nnoremap <silent> <C-j> :<C-u>silent bnext<CR>
    nnoremap <silent> <C-k> :<C-u>silent bprev<CR>
else
    nnoremap <silent> <C-j> :<C-u>silent bnext<CR>:<C-u>call <SID>get_buflists()<CR>
    nnoremap <silent> <C-k> :<C-u>silent bprev<CR>:<C-u>call <SID>get_buflists()<CR>
endif

nnoremap <silent> <C-x>u :<C-u>call <SID>buf_restore()<CR>
nnoremap <silent> <C-x>d     :Delete<CR>
nnoremap <silent> <C-x><C-d> :Delete!<CR>
" Tabpages 
function! s:move_to_tab()
    tab split
    tabprevious

    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif

    tabnext
endfunction

" Tabpages mapping
nnoremap <silent> <C-t>L  :<C-u>call <SID>move_tabpage("right")<CR>
nnoremap <silent> <C-t>H  :<C-u>call <SID>move_tabpage("left")<CR>
nnoremap <silent> <C-t>dh :<C-u>call <SID>close_all_left_tabpages()<CR>
nnoremap <silent> <C-t>dl :<C-u>call <SID>close_all_right_tabpages()<CR>

" Swap jk for gjgk 
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

function! s:vsplit_or_wincmdw()
    if winnr('$') == 1
        return ":vsplit\<CR>"
    else
        return ":wincmd w\<CR>"
    endif
endfunction
nnoremap <expr><silent> ss <SID>vsplit_or_wincmdw()
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

nnoremap t <Nop>
nnoremap <silent> [Space]t :<C-u>tabclose<CR>:<C-u>tabnew<CR>
nnoremap <silent> tt :<C-u>tabnew<CR>
nnoremap <silent> tT :<C-u>tabnew<CR>:<C-u>tabprev<CR>
nnoremap <silent> tc :<C-u>tabclose<CR>
nnoremap <silent> to :<C-u>tabonly<CR>

nnoremap <silent>z0 :<C-u>set foldlevel=<C-r>=foldlevel('.')<CR><CR>

" tig 
nnoremap <silent> [Space]g :<C-u>!tig blame +<C-r>=line('.')<CR> %<CR>:redraw!<CR>:


" __END__ 
" vim:fdm=marker expandtab fdc=3:

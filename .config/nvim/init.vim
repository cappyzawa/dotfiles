set foldmethod=marker

" init"{{{

" faster
if has('nvim')
  let g:loaded_python_provider = 0
  let g:python3_host_prog=$XDG_CONFIG_HOME . '/anyenv/envs/pyenv/shims/python3'
end

let g:false = 0
let g:true = 1

augroup MyAutoCmd
  autocmd!
augroup END

" }}}

" map "{{{
let g:mapleader=' '
let g:maplocalleader=' '

" Smart space mapping
nmap <Space> [Space]
xmap <Space> [Space]
noremap <Leader>h ^
noremap <Leader>l $

inoremap <BS> <Nop>
inoremap <Del> <Nop>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-h> <BS>
inoremap <C-d> <Del>

cnoremap <C-k> <UP>
cnoremap <C-j> <DOWN>
cnoremap <C-l> <RIGHT>
cnoremap <C-h> <LEFT>
cnoremap <C-d> <DELETE>
cnoremap <C-p> <UP>
cnoremap <C-n> <DOWN>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

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
vnoremap <C-j><C-j> <ESC>
onoremap jj <ESC>
inoremap j[Space] j
onoremap j[Space] j

" Make Y behave like other capitals
nnoremap Y y$
" expand path
cmap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <c-z> <c-r>=expand('%:p:r')<cr>
" Yank the entire file
nnoremap <Leader>y :<C-u>%y<CR>
nnoremap <Leader>Y :<C-u>%y<CR>

" Swap jk for gjgk
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
nnoremap J 10j
nnoremap K 10k
vnoremap J 10j
vnoremap K 10k

" window
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap s0 <C-w>=
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

" indent
" See: https://twitter.com/mattn_jp/status/1202603537521401856
vnoremap < <gv
vnoremap > >gv
" buffer
nnoremap <silent> <C-j> :<C-u>bprev<CR>
nnoremap <silent> <C-k> :<C-u>bnext<CR>

nnoremap t <Nop>
nnoremap <silent> [Space]t :<C-u>tabclose<CR>:<C-u>tabnew<CR>
nnoremap <silent> tt :<C-u>tabnew<CR>
nnoremap <silent> tT :<C-u>tabnew<CR>:<C-u>tabprev<CR>
nnoremap <silent> tc :<C-u>tabclose<CR>
nnoremap <silent> to :<C-u>tabonly<CR>

nnoremap <silent>z0 :<C-u>set foldlevel=<C-r>=foldlevel('.')<CR><CR>

" terminal
tnoremap <silent> jj <C-\><C-n>
tnoremap <silent> <C-j> j
tnoremap <silent> <C-k> k

nnoremap <silent> <Leader>vt :<C-u>vs \| terminal<CR>
nnoremap <silent> <Leader>st :<C-u>sp \| terminal<CR>
nnoremap <silent> <Leader>ve :<C-u>vs \| edit .<CR>
nnoremap <silent> <Leader>se :<C-u>sp \| edit .<CR>

if has('nvim')
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
endif
" }}}

" option "{{{

" Must be written at the last.  see :help 'secure'.
set secure

" Height for completion
set pumheight=10

" Fast
set ttyfast
set lazyredraw

" 1 tab = 2 spaces
set shiftwidth=2
set tabstop=2

" swap files are not created
set noswapfile

" backup files are not created
set nobackup

" long lines are not omitted
set display=lastline

set autoindent
set smartindent
set smarttab

set ignorecase
set smartcase
set incsearch
set hlsearch

set autoread
set autowrite

set nostartofline

set expandtab
set autoindent

set wrapscan

set showmatch
set matchtime=1

set matchpairs& matchpairs+=<:>

" Extend the command line completion
set wildmenu
" Wildmenu mode
set wildmode=longest,full

" Ignore compiled files
set wildignore&
set wildignore=.git,.hg,.svn
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.so,*.out,*.class
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=*.DS_Store

" Show line and column number
set ruler
set rulerformat=%m%r%=%l/%L

" String to put at the start of lines that have been wrapped.
let &showbreak = '+++ '

" Always display a status line
set laststatus=2

" Set command window height to reduce number of 'Press ENTER...' prompts
set cmdheight=2

" Show current mode (insert, visual, normal, etc.)
set showmode

" Show last command in status line
set showcmd

" Lets vim set the title of the console
set notitle

" Moving the cursor left and right will be modern.
set whichwrap=b,s,h,l,<,>,[,]

set hidden

" The maximum width of the input text
set textwidth=0

set formatoptions&
set formatoptions-=t
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o
set formatoptions-=v
set formatoptions+=l

" Increase or decrease items
set nrformats=alpha,hex

" Do not use visualbell
set novisualbell
set vb t_vb=

set noequalalways

set mousehide
set virtualedit=block
set virtualedit& virtualedit+=block

" Select newline character (either or both of CR and LF depending on system) automatically
set foldenable
set foldlevel=0

" History size
set history=10000
set wrap

" Enalbe termguicolors
set termguicolors

if has('clipboard')
	set clipboard=unnamed
endif

" Open new window on the right
set splitright
set splitbelow

if has('nvim')
  set wildoptions=pum
  set inccommand=nosplit
  set completeopt=menuone,noinsert
  set shortmess+=c
endif

" Shell = zsh
set sh=zsh
" }}}

" plug "{{{

" custom syntax
if has('nvim')
  augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
  augroup END
endif


lua require'plugins'
" }}}

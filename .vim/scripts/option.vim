if !exists('g:env')
	finish
endif

" set 256 colors
set t_Co=256

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

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
" A fullwidth character is displayed in vim properly.
if exists('&ambiwidth')
    set ambiwidth=double
endif

" Select newline character (either or both of CR and LF depending on system) automatically
set foldenable
set foldlevel=0
set foldcolumn=2

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,ucs-2le,ucs-2,cp932

" History size
set history=10000
set wrap

if has('clipboard')
	set clipboard=unnamed
endif

" Open new window on the right
set splitright

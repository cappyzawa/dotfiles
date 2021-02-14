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

" if g:plug.ready() && g:env.vimrc.plugin_on
"   " start to manage with vim-plug
"   call plug#begin(g:plug.base)
"
"   Plug 'junegunn/fzf'
"   Plug 'junegunn/fzf.vim'
"     let g:fzf_command_prefix = 'Fzf'
"
"   " syntax
"   " language support
"   if has('nvim')
"     " lsp
"     Plug 'neovim/nvim-lspconfig'
"     Plug 'nvim-lua/completion-nvim'
"       Plug 'steelsojka/completion-buffers'
"
"     Plug 'glepnir/lspsaga.nvim'
"
"     " finder
"     Plug 'nvim-lua/popup.nvim'
"     Plug 'nvim-lua/plenary.nvim'
"     Plug 'nvim-telescope/telescope.nvim'
"     Plug 'nvim-telescope/telescope-github.nvim'
"
"     " statusline
"     Plug 'glepnir/galaxyline.nvim'
"     Plug 'kyazdani42/nvim-web-devicons'
"
"     " syntax
"     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"     Plug 'glepnir/zephyr-nvim'
"
"     Plug 'cappyzawa/trim.nvim'
"     Plug 'cappyzawa/go-playground.nvim'
"   endif
"
"   Plug 'b4b4r07/vim-hcl', { 'for': 'hcl' }
"   Plug 'rhysd/vim-fixjson', { 'for': 'json' }
"   Plug 'google/vim-jsonnet', { 'for': ['jsonnet', 'libsonnet'] }
"   Plug 'jparise/vim-graphql'
"   Plug 'dense-analysis/ale'
"   Plug 'liuchengxu/vista.vim'
"     nmap <silent>tg :Vista coc<CR>
"     let g:vista#renderer#inable_icon = 1
"
"   " For only syntax
"   Plug 'cappyzawa/starlark.vim', { 'for': 'starlark' }
"   Plug 'cappyzawa/ytt.vim', { 'for': 'yaml' }
"   Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
"
"   Plug 'jiangmiao/auto-pairs'
"     let g:AutoPairsMapCR = 0
"
"   " Utils
"   Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }
"     let g:git_messenger_include_diff = 'current'
"     let g:git_messenger_always_into_popup = v:true
"
"     nnoremap <silent> <Leader>gm :<C-u>GitMessenger<CR>
"     let g:git_messenger_no_default_mappings = v:true
"
"   Plug 'tyru/open-browser.vim', { 'on': 'OpenGithubFile' }
"     Plug 'tyru/open-browser-github.vim', { 'on': 'OpenGithubFile' }
"       noremap <silent> <Leader>gf :<C-u>OpenGithubFile<CR>
"       vnoremap <silent> <Leader>gf :<C-u>'<,'>OpenGithubFile<CR>
"   Plug 'tomtom/tcomment_vim', { 'on': 'TComment' }
"     nnoremap <silent> gc :<C-u>TComment<CR>
"     vnoremap <silent> gc :<C-u>'<,'>TComment<CR>
"   Plug 'segeljakt/vim-silicon', { 'on': 'Silicon' }
"     let g:silicon = {
"           \   'theme':              'gruvbox',
"           \   'font':               'FiraCode Nerd Font',
"           \   'background':         '#FFFFFF',
"           \   'shadow-color':       '#555555',
"           \   'line-pad':                   2,
"           \   'pad-horiz':                 80,
"           \   'pad-vert':                 100,
"           \   'shadow-blur-radius':         0,
"           \   'shadow-offset-x':            0,
"           \   'shadow-offset-y':            0,
"           \   'line-number':           v:true,
"           \   'round-corner':          v:true,
"           \   'window-controls':       v:true,
"           \ }
"
"     let g:silicon['output'] = '~/Desktop/silicon-{time:%Y-%m-%d-%H%M%S}.png'
"
"   if has('nvim')
"     Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
"     Plug 'norcalli/nvim-colorizer.lua'
"   endif
"   if executable('terraform')
"     Plug 'hashivim/vim-terraform'
"       let g:terraform_align=1
"       let g:terraform_fold_sections=1
"       let g:terraform_fmt_on_save=0
"     Plug 'hashicorp/sentinel.vim'
"   endif
"   Plug 'guns/xterm-color-table.vim'
"   Plug 'zinit-zsh/zinit-vim-syntax'
"
"   " Views
"   Plug 'ryanoasis/vim-devicons'
"   Plug 'simeji/winresizer'
"     let g:winresizer_vert_resize = 1
"     let g:winresizer_horiz_resize = 1
"
"
"   " Add plugins to &runtimepath
"   call plug#end()
" endif

" custom "{{{
" if g:plug.is_installed('markdown-preview.nvim')
"   let g:mkdp_auto_start = 0
"   let g:mkdp_auto_close = 1
"   augroup MarkdownPreviewCustom
"     autocmd FileType markdown nnoremap <C-p> :<C-u>MarkdownPreview<CR>
"   augroup END
" endif
"
" if g:plug.is_installed('ale')
"   nnoremap <silent> <Leader>at :<C-u>ALEToggle<CR>
"   let g:ale_fix_on_save = 1
"   let g:ale_set_quickfix = 1
"   let g:ale_set_signs = 0
"   highlight link ALEErrorSign GruvboxRed
"   highlight link ALEWarningSign GruvboxYellow
"   let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"   let g:ale_disable_lsp = 1
"   let g:ale_virtualtext_cursor = 1
"   let g:ale_linters = {
"   \   'go': ['golint'],
"   \   'vim': ['vint'],
"   \   'rust': ['rustc'],
"   \   'terraform': ['tflint'],
"   \   'javascript': ['eslint'],
"   \   'typescript': ['eslint'],
"   \}
"
"   let g:ale_fixers = {
"   \   'go': ['gofmt','goimports'],
"   \   'elm': ['elm-format'],
"   \   'rust': ['rustfmt'],
"   \   'terraform': ['terraform'],
"   \   'javascript': ['eslint'],
"   \   'typescript': ['eslint'],
"   \   'markdown': [],
"   \}
"
"   " for elm
"   let g:ale_elm_format_executable = 'elm-format'
"   let g:ale_elm_format_options = '--yes --elm-version=0.19'
"
" endif
"
" if g:plug.is_installed('nvim-colorizer.lua')
"   lua require'colorizer'.setup()
" endif
"
" if g:plug.is_installed('trim.nvim')
" lua <<EOF
"   require('trim').setup({
"     -- if you want to ignore markdown file.
"     -- you can specify filetypes.
"     disable = {"markdown"},
"   })
" EOF
" endif
"
" if g:plug.is_installed('zephyr-nvim')
"   lua require('zephyr')
" endif
"
" if g:plug.is_installed('nvim-lspconfig')
" luafile $XDG_CONFIG_HOME/nvim/lua/lsp.lua
" endif
"
" if g:plug.is_installed('telescope.nvim')
" luafile $XDG_CONFIG_HOME/nvim/lua/finder.lua
" endif
"
" if g:plug.is_installed('galaxyline.nvim')
" luafile $XDG_CONFIG_HOME/nvim/lua/gl.lua
" endif
"
" if g:plug.is_installed('nvim-treesitter')
" luafile $XDG_CONFIG_HOME/nvim/lua/treesitter.lua
" endif
"
" }}}
"

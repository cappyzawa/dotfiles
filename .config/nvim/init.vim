set foldmethod=marker
" init"{{{

" Use plain vim
" when vim was invoked by 'sudo' command
" or, invoked as 'git difftool'
if exists('$SUDO_USER') || exists('$GIT_DIR')
  finish
endif

let g:false = 0
let g:true = 1

augroup MyAutoCmd
  autocmd!
augroup END

" Base functions
function! s:glob(from, pattern)
  return split(globpath(a:from, a:pattern), "[\r\n]")
endfunction

function! s:source(from, ...)
  let l:found = g:false
  for l:pattern in a:000
    for l:script in s:glob(a:from, l:pattern)
      execute 'source' escape(l:script, ' ')
      let l:found = g:true
    endfor
  endfor
  return l:found
endfunction

function! s:load(...) abort
  let l:base = expand($HOME.'/.vim')
  let l:found = g:true

  if len(a:000) > 0
    " Stop to load
    if index(a:000, g:false) != -1
      return g:false
    endif
    for l:file in a:000
      if !s:source(l:base, l:file)
        let l:found = s:source(l:base, '*[0-9]*_'.l:file)
      endif
    endfor
  else
    " Load all files starting with number
    let l:found = s:source(l:base, '*[0-9]*_*.vim')
  endif

  return l:found
endfunction

" Init
if !s:load('env.vim')
  " Finish if loading env.vim is failed
  finish
endif

let g:env.vimrc.plugin_on = g:true
let g:env.vimrc.manage_rtp_manually = g:false
let g:env.vimrc.plugin_on =
      \ g:env.vimrc.manage_rtp_manually == g:true
      \ ? g:false
      \ : g:env.vimrc.plugin_on

if g:env.is_starting
  " Necesary for lots of cool vim things
  " http://rbtnn.hateblo.jp/entry/2014/11/30/174749

  scriptencoding utf-8
  set runtimepath&

  " Check if there are plugins not to be installed
  augroup vimrc-check-plug
    autocmd!
    if g:env.vimrc.check_plug_update == g:true
      autocmd VimEnter * if !argc() | call g:plug.check_installation() | endif
    endif
  augroup END

  " Vim starting time
  if has('reltime')
    let g:startuptime = reltime()
    augroup vimrc-startuptime
      autocmd!
      autocmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
            \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
  endif
endif


call s:load('option.vim')

if s:load('plug.vim')
  call s:load('custom.vim')
endif

" Must be written at the last.  see :help 'secure'.
set secure
" }}}

" func "{{{
function! s:echomsg(hl, msg)
	execute 'echohl' a:hl
	try
		echomsg a:msg
	finally
		echohl None
	endtry
endfunction

function! Error(msg) abort
	echohl ErrorMsg
	echo 'ERROR: ' . a:msg
	echohl None
	return g:false
endfunction

function! Warn(msg) abort
	echohl WarningMsg
	echo 'WARNING: ' . a:msg
	echohl None
	return g:true
endfunction

" }}}

" map "{{{
let g:mapleader=' '
let g:maplocalleader=' '

" Smart space mapping
nmap <Space> [Space]
xmap <Space> [Space]
noremap [Space]h ^
noremap [Space]l $

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

nnoremap n nzz
nnoremap N Nzz
nnoremap S *zz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" View file information
nnoremap <C-g> 1<C-g>

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

if has('nvim')
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
endif
" }}}

" command "{{{
" In particular effective when I am garbled in a terminal
command! -bang -bar -complete=file -nargs=? Utf8      edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932     edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Euc       edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16     edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be   edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? Jis       Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis      Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode   Utf16<bang> <args>

" Tried to make a file note version
" Don't save it because dangerous.
command! WUtf8      setlocal fenc=utf-8
command! WIso2022jp setlocal fenc=iso-2022-jp
command! WCp932     setlocal fenc=cp932
command! WEuc       setlocal fenc=euc-jp
command! WUtf16     setlocal fenc=ucs-2le
command! WUtf16be   setlocal fenc=ucs-2
command! WJis       WIso2022jp
command! WSjis      WCp932
command! WUnicode   WUtf16

" Appoint a line feed
command! -bang -complete=file -nargs=? WUnix write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos  write<bang> ++fileformat=dos <args>  | edit <args>
command! -bang -complete=file -nargs=? WMac  write<bang> ++fileformat=mac <args>  | edit <args>
" }}}

" utils "{{{
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

" Restore the buffer that has been deleted
let s:bufqueue = []
augroup buffer-queue-restore
  autocmd!
  "autocmd BufDelete * call <SID>buf_enqueue(expand('#'))
augroup END
" }}}

" option "{{{
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

if has('nvim')
  set wildoptions=pum
endif


" Auto adjust cursor the first sugget
set completeopt+=noinsert

" Shell = zsh
set sh=zsh
" }}}

" plug "{{{
let g:plug = {
            \ 'plug':   expand(g:env.path.vim) . '/autoload/plug.vim',
            \ 'base':   expand(g:env.path.vim) . '/plugged',
            \ 'url':    'https://raw.github.com/junegunn/vim-plug/master/plug.vim',
            \ 'github': 'https://github.com/junegunn/vim-plug',
            \ }

function! g:plug.ready()
    return filereadable(l:self.plug)
endfunction

if g:plug.ready() && g:env.vimrc.plugin_on
    " start to manage with vim-plug
    call plug#begin(g:plug.base)

    " file and directory
    Plug 'Shougo/deol.nvim', { 'on': 'Deol' }
      let g:deol#shell_history_path = '~/.zsh_history'
      nnoremap <silent> <Leader>df :<C-u>Deol -split=floating<CR>
      nnoremap <silent> <Leader>dv :<C-u>Deol -split=vertical<CR>
      nnoremap <silent> <Leader>dh :<C-u>Deol -split=horizontal<CR>

    " syntax
    " language support
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
    Plug 'zplug/vim-zplug', { 'for': 'zplug' }
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'b4b4r07/vim-hcl', { 'for': 'hcl' }
    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'rhysd/vim-fixjson', { 'for': 'json' }
    Plug 'mattn/goplayground-vim', { 'for': 'go' }
    Plug 'godlygeek/tabular', {'for': 'markdown'}
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'posva/vim-vue', { 'for': 'vue' }
    Plug 'ElmCast/elm-vim', { 'for': 'elm' }
    Plug 'cappyzawa/nim.vim', { 'for': 'nim' }
    Plug 'dense-analysis/ale'

    " for only syntax
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'cappyzawa/starlark.vim', { 'for': 'starlark' }

    " for ytt
    Plug 'cappyzawa/ytt.vim', { 'for': 'yaml' }

    " Testing Tools
    Plug 'junegunn/vader.vim', { 'for': 'vim' }

    " Utils
    Plug 'jiangmiao/auto-pairs'

    Plug 'tyru/open-browser.vim', { 'on': '<Plug>(openbrowser-smart-search)' }
      let g:netrw_nogx = 1 " disable netrw's gx mapping.
      nmap gx <Plug>(openbrowser-smart-search)
      vmap gx <Plug>(openbrowser-smart-search)
    Plug 'tyru/open-browser-github.vim', { 'on' : ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq'] }
      nnoremap <silent> [Space]ogf :<C-u>OpenGithubFile<CR>
      nnoremap <silent> [Space]ogi :<C-u>OpenGithubIssue<CR>
      nnoremap <silent> [Space]ogp :<C-u>OpenGithubPullReq<CR>

    Plug 'rhysd/git-messenger.vim'
    Plug 'cappyzawa/fly-lint.vim', { 'for': 'yaml' }
    Plug 'cappyzawa/sd-validate.vim', { 'for': 'yaml' }
    Plug 'christianrondeau/vim-base64'
    Plug 'tpope/vim-fugitive'
    Plug 'tomtom/tcomment_vim'
    Plug 'segeljakt/vim-silicon', { 'on': 'Silicon' }
      let g:silicon = {
        \ 'theme':              'OneHalfDark',
        \ 'font':               'Droid Sans Mono Slashed for Powerline',
        \ 'background':         '#ffffff',
        \ 'shadow-color':       '#555555',
        \ 'line-pad':                   2,
        \ 'pad-horiz':                  0,
        \ 'pad-vert':                   0,
        \ 'shadow-blur-radius':         0,
        \ 'shadow-offset-x':            0,
        \ 'shadow-offset-y':            0,
        \ 'line-number':           v:true,
        \ 'round-corner':          v:true,
        \ 'window-controls':       v:true,
        \ }


    Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
    Plug 'cappyzawa/vault.nvim'
    Plug 'ap/vim-css-color'

    " Theme
    Plug 'joshdick/onedark.vim'

    " Views
    Plug 'vim-airline/vim-airline'
    Plug 'simeji/winresizer'
    Plug 'majutsushi/tagbar'
    Plug 'bling/vim-bufferline'

    " Add plugins to &runtimepath
    call plug#end()
endif

" Add plug's plugins
let g:plug.plugs = get(g:, 'plugs', {})
let g:plug.list  = keys(g:plug.plugs)

if !g:plug.ready()
    function! g:plug.init()
        let ret = system(printf('curl -fLo %s --create-dirs %s', self.plug, self.url))
        "call system(printf("git clone %s", self.github))
        if v:shell_error
            return Error('g:plug.init: error occured')
        endif

        " Restart vim
        if !g:env.is_gui
            silent! !vim
            quit!
        endif
    endfunction
    command! PlugInit call g:plug.init()

    if g:env.vimrc.suggest_neobundleinit == g:true
      augroup PlugReady
        autocmd! VimEnter * redraw
                    \ | echohl WarningMsg
                    \ | echo "You should do ':PlugInit' at first!"
                    \ | echohl None
      augroup END
    else
        " Install vim-plug
        PlugInit
    endif
endif

function! g:plug.is_installed(strict, ...)
    let list = []
    if type(a:strict) != type(0)
        call add(list, a:strict)
    endif
    let list += a:000

    for arg in list
        let name   = substitute(arg, '^vim-\|\.vim$', '', 'g')
        let prefix = 'vim-' . name
        let suffix = name . '.vim'

        if a:strict == 1
            let name   = arg
            let prefix = arg
            let suffix = arg
        endif

        if has_key(self.plugs, name)
                    \ ? isdirectory(self.plugs[name].dir)
                    \ : has_key(self.plugs, prefix)
                    \ ? isdirectory(self.plugs[prefix].dir)
                    \ : has_key(self.plugs, suffix)
                    \ ? isdirectory(self.plugs[suffix].dir)
                    \ : g:false
            continue
        else
            return g:false
        endif
    endfor

    return g:true
endfunction

function! g:plug.is_rtp(p)
    return index(split(&runtimepath, ','), get(l:self.plugs[a:p], 'dir')) != -1
endfunction

function! g:plug.is_loaded(p)
    return g:plug.is_installed(1, a:p) && g:plug.is_rtp(a:p)
endfunction

function! g:plug.check_installation()
    if empty(l:self.plugs)
        return
    endif

    let l:list = []
    for [l:name, l:spec] in items(l:self.plugs)
        if !isdirectory(l:spec.dir)
            call add(l:list, l:spec.uri)
        endif
    endfor

    if len(l:list) > 0
        let l:unplugged = map(l:list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')

        " Ask whether installing plugs like NeoBundle
        echomsg 'Not installed plugs: ' . string(l:unplugged)
        if confirm('Install plugs now?', "yes\nNo", 2) == 1
            PlugInstall
            " Close window for vim-plug
            silent! close
            " Restart vim
            if !g:env.is_gui
                silent! !vim
                quit!
            endif
        endif
    endif
endfunction

if g:plug.ready() && g:env.vimrc.plugin_on
    function! PlugList(A,L,P)
        return join(g:plug.list, "\n")
    endfunction

    command! -nargs=1 -complete=custom,PlugList PlugHas
                \ if g:plug.is_installed('<args>')
                \ | echo g:plug.plugs['<args>'].dir
                \ | endif
endif
" }}}

" custom "{{{
if g:plug.is_installed('enhancd')
  let g:enhancd_action = g:plug.is_installed('dirvish') ? 'Dirvish' : 'Ex'
endif

if g:plug.is_installed('asyncomplete.vim')
  let g:lsp_async_completion = 1
endif

if g:plug.is_installed('tcomment_vim')
  nnoremap <silent> ytt :<C-u>call tcomment#type#Define('yaml', '#@ %s')<CR>
  nnoremap <silent> yaml :<C-u>call tcomment#type#Define('yaml', '# %s')<CR>
endif

if g:plug.is_installed('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_no_default_key_mappings = 1
endif

if g:plug.is_installed('markdown-preview.nvim')
  let g:mkdp_auto_start = 0
  let g:mkdp_auto_close = 1
  augroup MarkdownPreviewCustom
    autocmd FileType markdown nnoremap <C-p> :<C-u>MarkdownPreview<CR>
  augroup END
endif

if g:plug.is_installed('vim-bufferline')
  let g:bufferline_active_buffer_right = '🚀'
  let g:bufferline_echo = 0
endif

if g:plug.is_installed('ale')

  nnoremap <silent> <Leader>at :<C-u>ALEToggle<CR>

  let g:ale_fix_on_save = 1
  let g:ale_set_quickfix = 1
  let g:ale_sign_error = '🔥'
  let g:ale_sign_warning = '⚡️'
  let g:ale_echo_msg_error_str = '🔥'
  let g:ale_echo_msg_warning_str = '⚡️'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_disable_lsp = 1
  let g:ale_linters = {
  \   'go': ['golint'],
  \   'ruby': ['rubocop'],
  \   'vim': ['vint'],
  \   'rust': ['rustc'],
  \}
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'go': ['gofmt','goimports'],
  \   'ruby': ['rubocop'],
  \   'elm': ['elm-format'],
  \   'rust': ['rustfmt'],
  \}

  " for elm
  let g:ale_elm_format_executable = 'elm-format'
  let g:ale_elm_format_options = '--yes --elm-version=0.19'

  " for markdown
  augroup ale_custom
    autocmd!
    autocmd FileType markdown let g:ale_fix_on_save = 0
  augroup END
endif

if g:plug.is_installed('git-messenger.vim')
  let g:git_messenger_include_diff='current'
  let g:git_messenger_always_into_popup=v:true
endif

if g:plug.is_installed('onedark.vim')
  augroup ondarkGroup
    autocmd!
    let s:white = {'gui': '#ABB2BF', 'cterm': '145', 'cterm16': '7'}
    autocmd ColorScheme * call onedark#set_highlight("Normal", {'fg': s:white})
  augroup END
  syntax on
  colorscheme onedark
endif

if g:plug.is_installed('tagbar')
  nnoremap <silent> <C-]> :<C-u>TagbarToggle<CR>
endif

if g:plug.is_installed('vim-emoji')
  set completefunc=emoji#complete
endif

if g:plug.is_installed('vault.nvim')
  let g:vault_default_path_prefix = 'concourse/main'
endif

if g:plug.is_installed('elm-vim')
  let g:elm_format_autosave = 0
  let g:elm_setup_keybinding = 0
  let g:elm_jump_to_error = 0
endif

if g:plug.is_installed('vim-airline')
  let g:airline_theme='onedark'
  let g:airline#extensions#bufferline#overwrite_variables = 0
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#ale#enabled = 1

  let g:airline#extensions#ale#error_symbol = '🔥'
  let g:airline#extensions#ale#warning_symbol = '⚡️'
endif

if g:plug.is_installed('winresizer')
  let g:winresizer_vert_resize = 1
  let g:winresizer_horiz_resize = 1
endif

if g:plug.is_installed('vim-go')
  let g:go_def_mapping_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go#use_vimproc = 0
  let g:go_auto_sameids = 1
  let g:go_fmt_autosave = 0
  let g:go_jump_to_error = 0
  let g:go_mod_fmt_autosave = 0
  let g:go_def_mode = 'gopls'
  let g:go_info_mode = 'gopls'
  let g:go_gocode_propose_source = 0
  let g:go_highlight_types = 1
  let g:go_template_autocreate = 0
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_gocode_unimported_packages = 1
  let g:sonictemplate_enable_pattern = 0
  let g:go_auto_type_info = 0

  let g:go_debug_windows = {
        \ 'stack': 'rightbelow 10new',
        \ 'vars': 'leftabove 50vnew',
        \ }

  nnoremap <silent> <F9> :GoDebugBreakpoint<CR>
  nnoremap <silent> <F5> :GoDebugContinue<CR>
  nnoremap <silent> <F10> :GoDebugNext<CR>
  nnoremap <silent> <F11> :GoDebugStep<CR>
  nnoremap <silent> <F12> :GoDebugStepOut<CR>
  nnoremap <silent> <F6> call go#debug#Print(<q-args>)
endif

if g:plug.is_installed('vim-json')
  let g:vim_json_syntax_conceal = 0
endif

if g:plug.is_installed('coc.nvim')
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gt <Plug>(coc-rename)
  nmap <silent> gl <Plug>(coc-codelens-action)
  nnoremap <silent> gk :call <SID>show_documentation()<CR>

  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! s:show_documentation()
    if &filetype ==# 'vim'
      execute 'h '.expand('<cword>')
    else
      if coc#util#has_float()
        call coc#util#float_hide()
      else
        call CocActionAsync('doHover')
      endif
    endif
  endfunction
  augroup CocCustom
    autocmd FileType elm setlocal tabstop=4 softtabstop=4 shiftwidth=4
  augroup END

  nnoremap <silent><C-f><C-f> :<C-u>CocList<CR>
endif
" }}}

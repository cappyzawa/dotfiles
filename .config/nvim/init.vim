set foldmethod=marker

" init"{{{

" faster
if has('nvim')
  let g:python3_host_prog=$XDG_CONFIG_HOME . '/.anyenv/envs/pyenv/shims/python'
end

let g:false = 0
let g:true = 1

augroup MyAutoCmd
  autocmd!
augroup END

" Init
" env "{{{
function! s:vimrc_environment()
    let l:env = {}
    let l:env.is_ = {}

    let l:env.is_.windows = has('win16') || has('win32') || has('win64')
    let l:env.is_.cygwin = has('win32unix')
    let l:env.is_.mac = !l:env.is_.windows && !l:env.is_.cygwin
                \ && (has('mac') || has('macunix') || has('gui_macvim') ||
                \    (!executable('xdg-open') &&
                \    system('uname') =~? '^darwin'))
    let l:env.is_.linux = !l:env.is_.mac && has('unix')


    let l:env.is_starting = has('vim_starting')
    let l:env.is_gui      = has('gui_running')

    let l:env.hostname    = substitute(hostname(), '[^\w.]', '', '')

    " vim
    if l:env.is_.windows
        let l:vimpath = expand('~/vimfiles')
    else
        let l:vimpath = expand('~/.vim')
    endif

    let l:env.path = {
                \ 'vim': l:vimpath,
                \ }

    let l:env.bin = {
                \ 'ag': executable('ag'),
                \ 'osascript': executable('osascript'),
                \ 'open': executable('open'),
                \ 'chmod': executable('chmod'),
                \ 'qlmanage': executable('qlmanage'),
                \ }

    " tmux
    let l:env.is_tmux_running = !empty($TMUX)
    let l:env.tmux_proc = system('tmux display-message -p "#W"')

  "echo get(g:env.vimrc, 'enable_plugin', g:false)
    let l:env.vimrc = {
              \ 'plugin_on': g:true,
              \ 'suggest_neobundleinit': g:true,
              \ 'goback_to_eof2bof': g:false,
              \ 'save_window_position': g:true,
              \ 'restore_cursor_position': g:true,
              \ 'statusline_manually': g:true,
              \ 'add_execute_perm': g:false,
              \ 'colorize_statusline_insert': g:true,
              \ 'manage_rtp_manually': g:true,
              \ 'auto_cd_file_parentdir': g:true,
              \ 'ignore_all_settings': g:true,
              \ 'check_plug_update': g:true,
              \ }

    return l:env
endfunction

" g:env is an environment variable in vimrc
let g:env = s:vimrc_environment()

function! IsWindows() abort
    return g:env.is_.windows
endfunction

function! IsMac() abort
    return g:env.is_.mac
endfunction
" }}}
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

endif

" Must be written at the last.  see :help 'secure'.
set secure
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

" utils "{{{
" Restore cursor position
if g:env.vimrc.restore_cursor_position == g:true
  function! s:restore_cursor_postion()
    if line("'\"") <= line('$')
      normal! g`"
      return 1
    endif
  endfunction
  augroup restore-cursor-position
    autocmd!
    autocmd BufWinEnter * call s:restore_cursor_postion()
  augroup END
endif

" Restore the buffer that has been deleted
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

" custom syntax
augroup CustomSyntax
  autocmd BufNewFile,BufRead *.cw,*.jira set filetype=confluencewiki
augroup END

if g:plug.ready() && g:env.vimrc.plugin_on
    " start to manage with vim-plug
    call plug#begin(g:plug.base)

    Plug 'Shougo/deol.nvim', { 'on': 'Deol' }
      let g:deol#shell_history_path = '~/.zsh_history'
      nnoremap <silent> <Leader>df :<C-u>Deol -split=floating<CR>
      nnoremap <silent> <Leader>dv :<C-u>Deol -split=vertical<CR>
      nnoremap <silent> <Leader>dh :<C-u>Deol -split=horizontal<CR>
    Plug 't9md/vim-choosewin', { 'on': '<Plug>(choosewin)' }
      let g:choosewin_overlay_enable = 1
      nmap - <Plug>(choosewin)

    " syntax
    " language support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'b4b4r07/vim-hcl', { 'for': 'hcl' }
    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'rhysd/vim-fixjson', { 'for': 'json' }
    Plug 'mattn/goplayground-vim', { 'for': 'go' }
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'google/vim-jsonnet', { 'for': ['jsonnet', 'libsonnet'] }
    Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }

    Plug 'vim-scripts/confluencewiki.vim', { 'for': 'confluencewiki' }
    " Plug 'posva/vim-vue', { 'for': 'vue' }
    Plug 'dense-analysis/ale'

    " For only syntax
    Plug 'cappyzawa/starlark.vim', { 'for': 'starlark' }
    Plug 'cappyzawa/ytt.vim', { 'for': 'yaml' }
    Plug 'andys8/vim-elm-syntax', { 'for': 'elm' }
    Plug 'cappyzawa/nim.vim', { 'for': 'nim' }

    " Testing Tools
    Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }

    " Utils
    Plug 'jiangmiao/auto-pairs'

    Plug 'tyru/open-browser-github.vim', { 'on' : ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq'] }
      nnoremap <silent> <Leader>gf :<C-u>OpenGithubFile<CR>
      nnoremap <silent> <Leader>gi :<C-u>OpenGithubIssue<CR>
      nnoremap <silent> <Leader>gp :<C-u>OpenGithubPullReq<CR>
        Plug 'tyru/open-browser.vim'
        nmap gx <Plug>(openbrowser-smart-search)
        vmap gx <Plug>(openbrowser-smart-search)

    Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }
      let g:git_messenger_include_diff = 'current'
      let g:git_messenger_always_into_popup = v:true

      nnoremap <silent> <Leader>gm :<C-u>GitMessenger<CR>
      let g:git_messenger_no_default_mappings = v:true

    Plug 'cappyzawa/fly-lint.vim', { 'for': 'yaml' }
    Plug 'cappyzawa/sd-validate.vim', { 'for': 'yaml' }
    Plug 'christianrondeau/vim-base64', { 'for': 'yaml' }
    Plug 'tpope/vim-fugitive'
    Plug 'tomtom/tcomment_vim', { 'on': 'TComment' }
      nnoremap <silent> gc :<C-u>TComment<CR>
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
    " TODO: replace this
    " See: original plugin has an issue: https://github.com/glacambre/firenvim/issues/175
    " Plug 'glacambre/firenvim', { 'do': function('firenvim#install') }
    Plug 'cappyzawa/firenvim', { 'do': function('firenvim#install') }
      let g:firenvim_config = {
        \ 'localSettings': {
          \ 'github\.com': {
            \ 'selector': 'textarea',
            \ 'priority': 0,
      \       },
      \     }
        \ }

      let g:dont_write = v:false
      function! My_Write(timer) abort
        let g:dont_write = v:false
        write
      endfunction

      function! Delay_My_Write() abort
        if g:dont_write
          return
        end
        let g:dont_write = v:true
        call timer_start(10000, 'My_Write')
      endfunction

      au TextChanged * ++nested call Delay_My_Write()
      au TextChangedI * ++nested call Delay_My_Write()

    Plug 'cappyzawa/vault.nvim', { 'for': 'yaml' }
    Plug 'ap/vim-css-color'
    Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
    if ! has('nvim')
      Plug 'skanehira/translate.vim', { 'on': 'Translate' }
        let g:translate_source = "en"
        let g:translate_target = "ja"
        let g:translate_winsize = 10
    endif


    " Theme
    Plug 'joshdick/onedark.vim'

    " Views
    Plug 'bling/vim-bufferline'
    Plug 'vim-airline/vim-airline'
    Plug 'simeji/winresizer'
    Plug 'majutsushi/tagbar'
      nnoremap <silent> <C-]> :<C-u>TagbarToggle<CR>

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
    let l:list = []
    if type(a:strict) != type(0)
        call add(list, a:strict)
    endif
    let l:list += a:000

    for l:arg in l:list
        let l:name   = substitute(l:arg, '^vim-\|\.vim$', '', 'g')
        let l:prefix = 'vim-' . l:name
        let l:suffix = l:name . '.vim'

        if a:strict == 1
            let l:name   = l:arg
            let l:prefix = l:arg
            let l:suffix = l:arg
        endif

        if has_key(self.plugs, l:name)
                    \ ? isdirectory(self.plugs[l:name].dir)
                    \ : has_key(self.plugs, l:prefix)
                    \ ? isdirectory(self.plugs[l:prefix].dir)
                    \ : has_key(self.plugs, l:suffix)
                    \ ? isdirectory(self.plugs[l:suffix].dir)
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
    if empty(self.plugs)
        return
    endif

    let list = []
    for [name, spec] in items(self.plugs)
        if !isdirectory(spec.dir)
            call add(list, spec.uri)
        endif
    endfor

    if len(list) > 0
        let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')

        " Ask whether installing plugs like NeoBundle
        echomsg 'Not installed plugs: ' . string(unplugged)
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

if g:plug.is_installed('onedark.vim')
  augroup ondarkGroup
    autocmd!
    let s:white = {'gui': '#ABB2BF', 'cterm': '145', 'cterm16': '7'}
    autocmd ColorScheme * call onedark#set_highlight("Normal", {'fg': s:white})
  augroup END
  syntax on
  colorscheme onedark
endif

if g:plug.is_installed('vault.nvim')
  let g:vault_default_path_prefix = 'concourse/main'
endif

if g:plug.is_installed('elm-vim')
  let g:elm_format_autosave = 0
  let g:elm_setup_keybinding = 0
  let g:elm_jump_to_error = 0
endif

if g:plug.is_installed('julia-vim')
  let g:default_julia_version = "1.2.0"
endif

if g:plug.is_installed('vim-airline')
  let g:airline_skip_empty_sections = 1
  let g:airline_theme='onedark'
  let g:airline_extensions = ['branch',
        \ 'ale',
        \ 'bufferline']


  let g:airline#extensions#tagbar#enabled = 1
  let g:airline_lazyloaded_tagbar = 1
  let g:airline#extensions#bufferline#overwrite_variables = 0
  let g:airline#extensions#ale#error_symbol = '🔥'
  let g:airline#extensions#ale#warning_symbol = '⚡️'
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

if g:plug.is_installed('winresizer')
  let g:winresizer_vert_resize = 1
  let g:winresizer_horiz_resize = 1
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

if executable('vim-language-sever')
  let g:markdown_forced_languages = [
    \ 'vim',
    \ 'help'
    \ ]
endif
" }}}

" lsp {{{
if has('nvim')
  call lsp#set_log_level("debug")
  function! s:show_documentation_for_lsp()
    if &filetype ==# 'vim'
      execute 'h '.expand('<cword>')
    else
      call lsp#text_document_hover()
    endif
  endfunction

  call lsp#add_filetype_config({
    \ 'filetype': 'rust',
    \ 'name': 'rls',
    \ 'cmd': 'rls',
    \ 'capabilities': {
    \   'clippy_preference': 'on',
    \   'all_targets': v:false,
    \   'build_on_save': v:true,
    \   'wait_to_build': 0
    \ }})
  call lsp#add_filetype_config({
    \ 'filetype': ['bash', 'sh', 'zsh'],
    \ 'name': 'bashls',
    \ 'cmd': ['bash-language-server', 'start'],
    \ })
  call lsp#add_filetype_config({
    \ 'filetype': 'vim',
    \ 'name': 'vimls',
    \ 'cmd': ['vim-language-server', '--stdio'],
    \ 'init_options': {
      \ 'iskeyword':'@,48-57,_,192-255,-#',
      \ 'vimruntime': '',
      \ 'runtimepath': '',
      \ 'diagnostic': {
        \ 'enable': v:true,
        \ },
      \ 'indexes': {
        \ 'runtimepath': v:true,
        \ 'gap': 100,
        \ 'count': 3,
        \ 'projectRootPatterns': ['strange-root-pattern', '.git', 'autoload', 'plugin']
        \ },
      \ 'suggest': {
        \ 'fromVimruntime': v:true,
        \ 'fromRuntimepath': v:false,
        \ },
      \ },
    \ })

  function! s:use_builtin_lspc()
    nnoremap <silent> gk :call <SID>show_documentation_for_lsp()<CR>
    nnoremap <silent> gd :call lsp#text_document_definition()<CR>
    nnoremap <silent> gi :call lsp#text_document_implementation()<CR>
    nnoremap <silent> gt :call lsp#text_document_rename()<CR>
  endfunction

  autocmd FileType rust,bash,sh,zsh,vim call s:use_builtin_lspc()
endif
" }}}

if !exists('g:env')
    finish
endif

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
    Plug 'Shougo/deol.nvim'

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
    Plug 'w0rp/ale'

    " for only syntax
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'cappyzawa/starlark.vim', { 'for': 'starlark' }

    " for ytt
    Plug 'cappyzawa/ytt.vim', { 'for': 'yaml' }

    " Testing Tools
    Plug 'junegunn/vader.vim'

    " Utils
    Plug 'jiangmiao/auto-pairs'
    Plug 'tyru/open-browser.vim'
    Plug 'tyru/open-browser-github.vim'
    Plug 'rhysd/git-messenger.vim'
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'cappyzawa/fly-lint.vim', { 'for': 'yaml' }
    Plug 'cappyzawa/sd-validate.vim', { 'for': 'yaml' }
    Plug 'christianrondeau/vim-base64'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/vim-emoji'
    Plug 'tomtom/tcomment_vim'

    Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
    Plug 'cappyzawa/vault.nvim'

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

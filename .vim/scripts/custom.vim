if !exists('g:env')
  finish
endif

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

if g:plug.is_installed('denite.nvim')
  call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')
  call denite#custom#map('normal', 'jj', '<denite:quit>', 'noremap')
  call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
  call denite#custom#map('normal', "<C-v>", '<denite:do_action:vsplit>')


  call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

  call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
          \ [ '.git/', '.ropeproject/', '__pycache__/',
          \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
          \   '.idea/', 'vendor/', 'plugged/'])

  nnoremap <silent> <Leader>ff :Denite file/rec<CR>
  nnoremap <silent> <Leader>j :Denite file/old<CR>
  nnoremap <silent> <C-f><C-f> :Denite grep<CR>
  call denite#custom#option('default', 'prompt', '🔍')
  if executable('rg')
    call denite#custom#var('file_rec', 'command',
          \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading', '-uu'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif
endif

if g:plug.is_installed('auto_pairs')
  let g:AutoPairsFlyMode = 1
endif

if g:plug.is_installed('open-browser.vim')
	let g:netrw_nogx = 1 " disable netrw's gx mapping.
	nmap gx <Plug>(openbrowser-smart-search)
	vmap gx <Plug>(openbrowser-smart-search)
endif

if g:plug.is_installed('open-browser-github.vim')
  nnoremap <silent> [Space]ogf :<C-u>OpenGithubFile<CR>
  nnoremap <silent> [Space]ogi :<C-u>OpenGithubIssue<CR>
  nnoremap <silent> [Space]ogp :<C-u>OpenGithubPullReq<CR>
endif

if g:plug.is_installed('previm')
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  nnoremap <silent> <C-p> :<C-u>PrevimOpen<CR>
endif

if g:plug.is_installed('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
endif

if g:plug.is_installed('ale')
  if &filetype != "markdown"
    let g:ale_fix_on_save = 1
  else
    let g:ale_fix_on_save = 0
  endif

  let g:ale_set_quickfix = 1
  let g:ale_echo_msg_error_str = '🔥'
  let g:ale_echo_msg_warning_str = '⚡️'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_linters = {
  \   'go': ['golint'],
  \}
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'go': ['gofmt','goimports'],
  \   'elm': ['elm-format'],
  \}

  " for elm
  let g:ale_elm_format_executable = "elm-format"
  let g:ale_elm_format_options = "--yes --elm-version=0.19"
endif

if g:plug.is_installed('onedark.vim')
  syntax on
  colorscheme onedark
endif

if g:plug.is_installed('nerdtree')
  nnoremap <silent> <C-]> :<C-u>NERDTreeToggle<CR>
  let NERDTreeMapOpenVSplit = "v"
  let NERDTreeMapOpenSplit = "s"
  let NERDTreeMapToggleHidden = "a"
endif

if g:plug.is_installed('nerdtree-git-plugin')
  let g:NERDTreeIndicatorMapCustom = {
        \ 'Modified'  : '⚡️',
        \ 'Staged'  : '🎉',
        \ 'Untracked' : '⭐',
        \ 'Renamed'   : '🔀',
        \ 'Deleted'   : '❌',
        \ 'Clean'   : '🚮',
        \ }
endif

if g:plug.is_installed('vim-emoji')
  set completefunc=emoji#complete
endif

if g:plug.is_installed('elm-vim')
  let g:elm_format_autosave = 0
  let g:elm_setup_keybinding = 0
  let g:elm_jump_to_error = 1
  nnoremap <silent> <Leader>em :<C-u>ElmMake<CR>
  nnoremap <silent> <Leader>emm :<C-u>ElmMakeMain<CR>
  nnoremap <silent> <Leader>et :<C-u>ElmTest<CR>
  nnoremap <silent> <Leader>er :<C-u>ElmRepl<CR>
  nnoremap <silent> <Leader>ed :<C-u>ElmErrorDetail<CR>
  nnoremap <silent> <Leader>es :<C-u>ElmBrowseDocs<CR>
  nnoremap <silent> <Leader>eb :<C-u>ElmFormat<CR>
endif

if g:plug.is_installed('vim-airline')
  let g:airline_theme='dark'
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#ale#enabled = 1
  let airline#extensions#ale#error_symbol = '🔥'
  let airline#extensions#ale#warning_symbol = '⚡️'
endif

if g:plug.is_installed('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
  inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
endif

if g:plug.is_installed('winresizer')
  let g:winresizer_vert_resize = 1
  let g:winresizer_horiz_resize = 1
endif

if g:plug.is_installed('')
endif

nnoremap <silent> <Leader>d :<C-u>LspDefinition<CR>
nnoremap <silent> <Leader>r :<C-u>LspReferences<CR>
nnoremap <silent> <Leader>i :<C-u>LspImplementation<CR>
nnoremap <silent> <Leader>t :<C-u>LspRename<CR>
nnoremap <silent> <Leader>ds :<C-u>LspDocumentSymbol<CR>
nnoremap <silent> <Leader>ws :<C-u>LspWorkspaceSymbol<CR>
nnoremap <silent> <Leader>df :<C-u>LspDocumentFormat<CR>
vnoremap <silent> <Leader>rf :<C-u>LspDocumentRangeFormat<CR>
nnoremap <silent> <Leader>b :<C-u>LspHover<CR>

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Go
if executable('gopls')
  augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'go-lang',
    \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
    \ 'whitelist': ['go'],
    \ })
  autocmd FileType python,go nmap gd <plug>(lsp-definition)<CR>
  augroup END
endif

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Ruby
if executable('solargraph')
  " gem install solargraph
  au User lsp_setup call lsp#register_server({
    \ 'name': 'solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'initialization_options': {"diagnostics": "true"},
    \ 'whitelist': ['ruby'],
    \ })
endif

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Docker
if executable('docker-langserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'docker-langserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
    \ 'whitelist': ['dockerfile'],
    \ })
endif

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Rust
if executable('rls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'rls',
    \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
    \ 'whitelist': ['rust'],
    \ })
endif

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-TypeScript
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \ 'whitelist': ['typescript', 'typescript.tsx'],
    \ })
endif

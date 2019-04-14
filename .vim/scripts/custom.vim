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
  call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
  call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>')


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
  nnoremap <silent> <C-r> :Denite command_history<CR>
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

  " Change default prompt
	call denite#custom#option('default', 'prompt', '🔍')

  call denite#custom#var('command_history','ignore_command_regexp', '')
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
  let g:ale_echo_msg_error_str = '🔥'
  let g:ale_echo_msg_warning_str = '⚡️'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_linters = {
  \   'go': ['golint'],
  \   'ruby': ['rubocop'],
  \   'vim': ['vint'],
  \}
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'go': ['gofmt','goimports'],
  \   'ruby': ['rubocop'],
  \   'elm': ['elm-format'],
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
  syntax on
  colorscheme onedark
endif

if g:plug.is_installed('tagbar')
  nnoremap <silent> <C-]> :<C-u>TagbarToggle<CR>
endif

if g:plug.is_installed('nerdtree')
  nnoremap <silent> <C-[> :<C-u>NERDTreeToggle<CR>
  let NERDTreeMapOpenVSplit = 'v'
  let NERDTreeMapOpenSplit = 's'
  let NERDTreeMapToggleHidden = 'a'
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
  let g:airline#extensions#bufferline#overwrite_variables = 0
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#ale#enabled = 1

  let g:airline#extensions#ale#error_symbol = '🔥'
  let g:airline#extensions#ale#warning_symbol = '⚡️'
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

if g:plug.is_installed('vim-go')
  let g:go_def_mapping_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go#use_vimproc = 0
  let g:go_auto_sameids = 1
  let g:go_fmt_autosave = 0
  let g:go_jump_to_error = 0
  let g:go_mod_fmt_autosave = 0
  let g:go_def_mode = 'gopls'
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
  let g:go_auto_type_info = 1
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
  nnoremap <silent> gk :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype ==# 'vim'
      execute 'h '.expand('<cword>')
    else
      if coc#util#has_float()
        pc
      else
        call CocAction('doHover')
      endif
    endif
  endfunction
  augroup CocCustom
    autocmd FileType go,rust,ruby call deoplete#custom#option('auto_complete', v:false)
  augroup END
endif

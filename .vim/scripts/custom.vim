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

if g:plug.is_installed('deol.nvim')
  let g:deol#shell_history_path = '~/.zsh_history'
  nnoremap <silent> <Leader>df :<C-u>Deol -split=floating<CR>
  nnoremap <silent> <Leader>dv :<C-u>Deol -split=vertical<CR>
  nnoremap <silent> <Leader>dh :<C-u>Deol -split=horizontal<CR>
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

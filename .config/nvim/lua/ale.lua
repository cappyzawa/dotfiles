local vim = vim

vim.g.ale_fix_on_save = 1
vim.g.ale_set_quickfix = 1
vim.g.ale_set_signs = 0
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_disable_lsp = 1
vim.g.ale_lint_on_enter = 0
vim.g.ale_linters = {
  go = {'golint'},
  vim = {'vint'},
  rust = {'rustc'},
  terraform = {'tflint'},
  javascript = {'eslint'},
  typescript = {'eslint'}
}
vim.g.ale_fixers = {
  go = {'gofmt', 'goimports'},
  elm = {'elm-format'},
  rust = {'rustfmt'},
  terraform = {'terraform'},
  javascript = {'eslint'},
  typescript = {'eslint'},
  markdown = {}
}
vim.g.ale_elm_format_executable = 'elm-format'
vim.g.ale_elm_format_options = '--yes --elm-version=0.19'

vim.cmd[[nnoremap <silent> <Leader>at :<C-u>ALEToggle<CR>]]

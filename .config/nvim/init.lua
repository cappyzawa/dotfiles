local vim = vim

-- map {{{
vim.g.mapleader=' '
vim.g.maplocalleader=' '

local keymap_opt = { noremap=true, silent=true }
local set_keymap = vim.api.nvim_set_keymap

-- nnoremap {{{
local nmap = {
  ['<Space>'] = '[Space]',
  ['<Leader>h'] = '^',
  ['<Leader>l'] = '$',
  ['<Up>'] = '<Nop>',
  ['<Down>'] = '<Nop>',
  ['<Left>'] = '<Nop>',
  ['<Right>'] = '<Nop>',
  Y = 'y$',
  J = '10j',
  K = '10k',
  sj = '<C-w>j',
  sk = '<C-w>k',
  sl = '<C-w>l',
  sh = '<C-w>h',
  sJ = '<C-w>J',
  sK = '<C-w>K',
  sL = '<C-w>L',
  sH = '<C-w>H',
  ['s>'] = '<C-w>>',
  ['s<'] = '<C-w><',
  ['s+'] = '<C-w>+',
  ['s-'] = '<C-w>-',
}

for k, v in pairs(nmap) do
  set_keymap('n', k, v, keymap_opt)
end
-- }}}

-- inoremap {{{
local imap = {
  ['<BS>'] = '<Nop>',
  ['<Del>'] = '<Nop>',
  ['<C-a>'] = '<Home>',
  ['<C-e>'] = '<End>',
  jj = '<ESC>',
  ['j[Space]'] = 'j',
}

for k, v in pairs(imap) do
  set_keymap('i', k, v, keymap_opt)
end
-- }}}

-- vnoremap {{{
local vmap = {
  ['<C-j><C-j>'] = '<ESC>',
  ['<Leader>h'] = '^',
  ['<Leader>l'] = '$',
  J = '10j',
  K = '10k',
  ['<'] = '<gv',
  ['>'] = '>gv',
}

for k, v in pairs(vmap) do
  set_keymap('v', k, v, keymap_opt)
end
-- }}}

-- }}}

-- option {{{
-- common {{{
vim.o.termguicolors = true

local common_opts = {
  hidden = true,
  splitright = true,
  splitbelow = true,
  wildoptions = 'pum',
  wildmenu = true,
  wildmode = 'longest,full',
  sh = 'zsh',
  completeopt = 'menu,menuone,noselect',
  clipboard = 'unnamedplus',
}
vim.cmd [[ set shortmess+=c ]]
vim.cmd [[ inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>" ]]
vim.cmd [[ inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>" ]]

for k, v in pairs(common_opts) do
  vim.api.nvim_set_option(k, v)
end
-- }}}

-- window {{{
local window_opts = {
  foldmethod = 'marker',
}

local cur_win = vim.api.nvim_get_current_win()
for k, v in pairs(window_opts) do
  vim.api.nvim_win_set_option(cur_win, k, v)
end
-- }}}

-- buffer {{{
local buffer_opts = {
  autoindent = true,
  smartindent = true,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  undofile = true,
}

local cur_buf = vim.api.nvim_get_current_buf()
for k, v in pairs(buffer_opts) do
  vim.api.nvim_buf_set_option(cur_buf, k, v)
end
-- }}}

-- }}}

-- au {{{
vim.cmd [[augroup LuaHighlight]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()]]
vim.cmd [[augroup END]]
-- }}}

require'plugins'

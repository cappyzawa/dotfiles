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
  swapfile = false,
  ignorecase = true,
  smartcase = true,
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
  expandtab = true,
  undofile = true,
}

local cur_buf = vim.api.nvim_get_current_buf()
for k, v in pairs(buffer_opts) do
  vim.api.nvim_buf_set_option(cur_buf, k, v)
end

-- https://github.com/neovim/neovim/issues/13433
vim.cmd [[set shiftwidth=2]]
vim.cmd [[set tabstop=2]]
-- }}}
-- }}}

-- au {{{
vim.cmd [[augroup LuaHighlight]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()]]
vim.cmd [[augroup END]]

vim.cmd [[augroup CursorRestore]]
vim.cmd [[  au Bufread * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]]
vim.cmd [[augroup END]]
-- }}}

-- plugins {{{
-- install packer {{{
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)
-- }}}
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require'plugins'.telescope()
    end
  }
  use {
    'cappyzawa/zephyr-nvim',
    requires = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require'zephyr'
    end,
  }
  use {
    'glepnir/galaxyline.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
      {'lewis6991/gitsigns.nvim'}
    },
    config = function()
      require'plugins'.galaxyline()
    end
  }
  use {
    'tomtom/tcomment_vim',
    config = function()
      require'plugins'.tcomment_vim()
    end
  }
  use 'jiangmiao/auto-pairs'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    run = ':TSUpdate',
    config = function()
      require'plugins'.treesitter()
    end
  }
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'lspcontainers/lspcontainers.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require'plugins'.lspconfig()
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
    },
    config = function()
      require'plugins'.nvim_cmp()
    end
  }
  use {
    'cappyzawa/trim.nvim',
    config = function ()
      require'trim'.setup({
        disable = {'markdown'},
      })
    end
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = 'markdown',
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end
  }
  use {
    'rhysd/git-messenger.vim',
    config = function()
      require'plugins'.git_messenger()
    end
  }
  use {
    'ggandor/lightspeed.nvim',
    config = function()
      require'plugins'.lightspeed()
    end
  }
  use 'zinit-zsh/zinit-vim-syntax'
  use 'cappyzawa/go-playground.nvim'
  use {
    'hashivim/vim-terraform',
    config = function()
      require'plugins'.terraform()
    end,
  }
  use {
    'tyru/open-browser-github.vim',
    requires = {
      'tyru/open-browser.vim'
    },
    cmd = {'OpenGithubFile'}
  }
  end)
-- }}}
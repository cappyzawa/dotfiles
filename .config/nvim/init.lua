local vim = vim

-- icons {{{
vim.g.w_sign = "ﯦ"
vim.g.e_sign = ""
vim.g.i_sign = ""
vim.g.h_sign = "ﯧ"
-- }}}

-- map {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.shiftwidth = 2
vim.o.tabstop = 2

local keymap_opt = { noremap = true, silent = true }
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
  ['s-'] = '<C-w>-'
}

for k, v in pairs(nmap) do set_keymap('n', k, v, keymap_opt) end
-- }}}

-- inoremap {{{
local imap = {
  ['<BS>'] = '<Nop>',
  ['<Del>'] = '<Nop>',
  ['<C-a>'] = '<Home>',
  ['<C-e>'] = '<End>',
  jj = '<ESC>',
  ['j[Space]'] = 'j'
}

for k, v in pairs(imap) do set_keymap('i', k, v, keymap_opt) end
-- }}}

-- vnoremap {{{
local vmap = {
  ['<C-j><C-j>'] = '<ESC>',
  ['<Leader>h'] = '^',
  ['<Leader>l'] = '$',
  J = '10j',
  K = '10k',
  ['<'] = '<gv',
  ['>'] = '>gv'
}

for k, v in pairs(vmap) do set_keymap('v', k, v, keymap_opt) end
-- }}}

-- tnoremap {{{
local tmap = { ['<ESC>'] = [[<c-\><c-n>]] }

for k, v in pairs(tmap) do set_keymap('t', k, v, keymap_opt) end
-- }}}
-- }}}

-- option {{{
-- common {{{
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
  ignorecase = true,
  smartcase = true,
  termguicolors = true,
  cmdheight = 1,
  mouse = '',
}

vim.cmd [[ set shortmess+=c ]]
vim.cmd [[ inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>" ]]
vim.cmd [[ inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>" ]]

for k, v in pairs(common_opts) do vim.api.nvim_set_option(k, v) end
-- }}}

-- window {{{
local window_opts = { foldmethod = 'marker', number = true }

local cur_win = vim.api.nvim_get_current_win()
for k, v in pairs(window_opts) do vim.api.nvim_win_set_option(cur_win, k, v) end
-- }}}

-- buffer {{{
local buffer_opts = {
  autoindent = true,
  smartindent = true,
  expandtab = true,
  undofile = true,
  swapfile = false,
}

local cur_buf = vim.api.nvim_get_current_buf()
for k, v in pairs(buffer_opts) do vim.api.nvim_buf_set_option(cur_buf, k, v) end
-- }}}
-- }}}

-- au {{{
vim.cmd [[augroup CursorRestore]]
vim.cmd [[  au Bufread * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]]
vim.cmd [[augroup END]]
-- }}}

-- plugins {{{
-- install packer {{{
local install_path = vim.fn.stdpath 'data' ..
    '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
    install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)
-- }}}
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'folke/tokyonight.nvim',
    config = function() require 'plugins'.tokyonight() end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons' }, { 'lewis6991/gitsigns.nvim' },
      { 'folke/tokyonight.nvim' }, { 'arkav/lualine-lsp-progress' }
    },
    config = function() require 'plugins'.lualine() end
  }
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }
  use {
    'windwp/nvim-autopairs',
    config = function() require('plugins').autopairs() end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    after = { 'plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '-' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' }
        }
      }
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    run = ':TSUpdate',
    config = function() require 'plugins'.treesitter() end
  }
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer', 'glepnir/lspsaga.nvim',
      'hrsh7th/nvim-cmp'
    },
    config = function()
      require 'plugins'.lspsaga()
      require 'plugins'.lspconfig()
    end
  }
  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons", "neovim/nvim-lspconfig" },
    after = { 'nvim-lspconfig' },
    config = function() require 'plugins'.trouble() end
  }
  use {
    "hrsh7th/cmp-copilot",
    requires = "github/copilot.vim",
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      "hrsh7th/vim-vsnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-path", "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-copilot",
    },
    config = function() require 'plugins'.nvim_cmp() end
  }
  use {
    'cappyzawa/trim.nvim',
    event = 'BufWritePre',
    config = function() require 'trim'.setup({ disable = { 'markdown', 'elm', 'lua' } }) end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' }, { 'cappyzawa/telescope-terraform.nvim' },
      { 'nvim-telescope/telescope-ghq.nvim' }, { 'nvim-telescope/telescope-github.nvim' }
    },
    config = function() require 'plugins'.telescope() end
  }
  use {
    'hashivim/vim-terraform',
    ft = { 'tf', 'hcl' },
    config = function() require 'plugins'.terraform() end
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = 'markdown'
  }
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle' },
    config = function() require 'colorizer'.setup() end
  }
  use {
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger',
    keys = { 'n', '<Leader>gm' },
    config = function() require 'plugins'.git_messenger() end
  }
  use {
    'cappyzawa/go-playground.nvim',
    cmd = 'GoPlayground',
    ft = 'go'
  }
  use {
    'tyru/open-browser-github.vim',
    requires = { 'tyru/open-browser.vim' },
    cmd = { 'OpenGithubFile' }
  }
  use {
    'tsandall/vim-rego',
    after = { 'tokyonight.nvim' },
  }
  use {
    'jjo/vim-cue',
    after = { 'tokyonight.nvim' },
  }
  use {
    'cappyzawa/starlark.vim',
    after = { 'tokyonight.nvim' },
  }
  use {
    'mattn/vim-maketable',
    cmd = { 'MakeTable', 'UnmakeTable' }
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    after = { 'tokyonight.nvim' },
    config = function() require 'plugins'.indent_blankline() end
  }
  use {
    'phaazon/hop.nvim',
    config = function() require 'plugins'.hop() end
  }
  use {
    'rcarriga/nvim-notify',
    config = function() require 'plugins'.notify() end
  }
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }
  use {
    'github/copilot.vim',
    run = function() vim.cmd [[ Copilot setup ]] end,
    config = function() require 'plugins'.copilot() end
  }
end)
-- }}}

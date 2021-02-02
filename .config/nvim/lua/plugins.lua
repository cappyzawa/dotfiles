-- bootstrapping {{{
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
 execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
 execute 'packadd packer.nvim'
end
-- }}}

vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

return require'packer'.startup(function()
  local use = require('packer').use
  use {'wbthomason/packer.nvim', opt = true}
  use {
    'glepnir/lspsaga.nvim',
    requires = {
      'neovim/nvim-lspconfig'
    }
  }
  use {
    'nvim-lua/completion-nvim',
    requires = {
      {'steelsojka/completion-buffers'},
      {'glepnir/lspsaga.nvim'},
    },
    config = function()
      require'lsp'
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-github.nvim'}
    },
    config = function()
      require'finder'
    end
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'glepnir/galaxyline.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons'}
    },
    config = function()
      require'gl'
    end
  }
  use {
    'glepnir/zephyr-nvim',
    config = function()
      require'zephyr'
    end
  }
  use {
    'tomtom/tcomment_vim',
    setup = function()
      vim.cmd [[nnoremap <silent> gc :<C-u>TComment<CR>]]
      vim.cmd [[vnoremap <silent> gc :<C-u>'<,'>TComment<CR>]]
    end,
    keys = {'gc'}
  }
  use {
    'jiangmiao/auto-pairs',
    config = function()
      vim.g.AutoPairsMapCR = 0
    end
  }
  use {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({
        -- if you want to ignore markdown file.
        -- you can specify filetypes.
        disable = {"markdown"},
      })
    end
  }
  use {
    'junegunn/fzf.vim',
    requires = {
      {'junegunn/fzf'}
    },
    config = function()
      vim.g.fzf_command_prefix = 'Fzf'
    end
  }
  use {
    'iamcco/markdown-preview.nvim',
    setup = function()
      vim.cmd [[nnoremap <silent> <C-p> :<C-u>MarkdownPreview<CR>]]
    end,
    config = {'vim.cmd[[doautocmd BufEnter]]', 'vim.cmd[[MarkdownPreview]]'},
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview'
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end
  }
  use {
    'hashivim/vim-terraform',
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fold_sections = 1
      vim.g.terraform_fmt_on_save = 0
    end,
    cond = [[vim.fn.executable('terraform')]]
  }
  use {
    'rhysd/git-messenger.vim',
    cmd = {'GitMessenger'},
    config = function()
      vim.g.git_messenger_include_diff = 'current'
      vim.g.git_messenger_always_into_popup = true
      vim.g.git_messenger_no_default_mappings = true
    end,
    setup = function()
      vim.cmd[[nnoremap <silent> <Leader>gm :<C-u>GitMessenger<CR>]]
    end
  }
  use {
    'simeji/winresizer',
    config = function()
      vim.g.winresizer_vert_resize = 1
      vim.g.winresizer_horiz_resize = 1
    end
  }
  use 'zinit-zsh/zinit-vim-syntax'
  use 'cappyzawa/starlark.vim'
  use 'aklt/plantuml-syntax'
end)

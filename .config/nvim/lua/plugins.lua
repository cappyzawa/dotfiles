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
      {
        'neovim/nvim-lspconfig'
      }
    },
    config = function()
      local saga = require 'lspsaga'
      local saga_opts = {
        error_sign = vim.g.e_sign,
        warn_sign = vim.g.w_sign,
        hint_sign = vim.g.h_sign
      }
      saga.init_lsp_saga(saga_opts)
      require'lsp'
    end
  }
  use {
    'hrsh7th/nvim-compe',
    config = function()
      vim.o.completeopt = "menu,menuone,noselect"
      require'compe'.setup{
        enabled = true,
        autocomplete = true,
        min_length = 1,

        source = {
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          nvim_lua = true,
          spell = true,
          tags = true,
        }
      }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-github.nvim'},
      {'nvim-telescope/telescope-packer.nvim'}
    },
    config = function()
      require'finder'
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      local treesitter_configs = require'nvim-treesitter.configs'

      treesitter_configs.setup {
        highlight = {
            enable = true,
            disable = {},
        },
      }
    end
  }
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
    'windwp/nvim-autopairs',
    config = function()
      local remap = vim.api.nvim_set_keymap
      local npairs = require('nvim-autopairs')
      npairs.setup{}
      -- skip it, if you use another global object
      _G.MUtils= {}
      vim.g.completion_confirm_key = ""
      MUtils.completion_confirm=function()
        if vim.fn.pumvisible() ~= 0  then
          if vim.fn.complete_info()["selected"] ~= -1 then
            vim.fn["compe#confirm"]()
            return npairs.esc("<c-y>")
          else
            vim.fn.nvim_select_popupmenu_item(0, false, false, {})
            vim.fn["compe#confirm"]()
            return npairs.esc("<c-n><c-y>")
          end
        else
          return npairs.check_break_line_char()
        end
      end
      remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
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
      vim.g.terraform_fmt_on_save = 1
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

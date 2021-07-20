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
        'neovim/nvim-lspconfig',
        'lspcontainers/lspcontainers.nvim',
      }
    },
    config = function()
      local saga = require 'lspsaga'
      local saga_opts = {
        error_sign = vim.g.e_sign,
        warn_sign = vim.g.w_sign,
        hint_sign = vim.g.h_sign,
        finder_action_keys = {
          open = 'o',
          vsplit = '<C-v>',
          split = '<C-s>',
          scroll_down = '<C-j>',
          scroll_up = '<C-k>',
        },
      }
      saga.init_lsp_saga(saga_opts)
      require'lsp'
    end
  }
  use {
    'hrsh7th/nvim-compe',
    config = function()
      vim.o.completeopt = "menuone,noselect"
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
      {'nvim-telescope/telescope-ghq.nvim'},
      {'nvim-telescope/telescope-packer.nvim'},
      {'nvim-telescope/telescope-symbols.nvim'},
      {'cappyzawa/telescope-terraform.nvim'}
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
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      local execute = vim.api.nvim_command
      local tree_sitter_path = vim.fn.stdpath('data')..'/site/pack/packer/start/nvim-treesitter'

      treesitter_configs.setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = {},
        },
      }

      -- hcl {{{
      execute('autocmd BufRead,BufNewFile *.hcl set filetype=hcl')
      -- }}}
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({
        keymaps = {
          noremap = true,
          buffer = true,
        }
      })
    end
  }
  use {
    'glepnir/galaxyline.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
      {'lewis6991/gitsigns.nvim'}
    },
    config = function()
      local eviline = vim.fn.stdpath('data') .. '/site/pack/packer/start/galaxyline.nvim/example/eviline.lua'
      vim.cmd('luafile ' .. eviline)
    end
  }
  use {
    'glepnir/zephyr-nvim',
    config = function()
      require'zephyr'
      vim.g.colors_name = 'zephyr'
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
            vim.defer_fn(function()
              vim.fn["compe#confirm"]("<cr>")
            end, 20)
            return npairs.esc("<c-n>")
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
      vim.cmd [[augroup CursorRestore]]
      vim.cmd [[  au Bufread * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]]
      vim.cmd [[augroup END]]
    end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    setup = function()
      vim.cmd [[autocmd FileType markdown nnoremap <silent> <C-p> :<C-u>MarkdownPreview<CR>]]
    end,
    config = {'vim.cmd[[doautocmd BufEnter]]', 'vim.cmd[[MarkdownPreview]]'},
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
    end,
    cmd = {'WinResizerStartResize'},
    keys = {'<C-e>'}
  }
  use {
    'ggandor/lightspeed.nvim',
    config = function()
      require'lightspeed'.setup {
        jump_to_first_match = true,
        jump_on_partial_input_safety_timeout = 400,
        -- This can get _really_ slow if the window has a lot of content,
        -- turn it on only if your machine can always cope with it.
        highlight_unique_chars = false,
        grey_out_search_area = true,
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
        full_inclusive_prefix_key = '<c-x>',
        -- By default, the values of these will be decided at runtime,
        -- based on `jump_to_first_match`.
        labels = nil,
        cycle_group_fwd_key = nil,
        cycle_group_bwd_key = nil,
      }
      local lightspeed_sc = {'f', 'F', 't', 'T'}
      for _, v in pairs(lightspeed_sc) do
        vim.api.nvim_set_keymap('n', v, string.format('reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_%s" : "%s"', v, v), {expr = true})
      end
    end,
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
  use 'zinit-zsh/zinit-vim-syntax'
  use 'cappyzawa/starlark.vim'
  use 'cappyzawa/go-playground.nvim'
  use 'aklt/plantuml-syntax'
  use 'JuliaEditorSupport/julia-vim'
  use 'alaviss/nim.nvim'
  use {
    'rust-lang/rust.vim',
    config = function()
      vim.g.rustfmt_autosave = 1
    end
  }

end)

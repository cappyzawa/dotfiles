local treesitter_configs = require'nvim-treesitter.configs'

treesitter_configs.setup {
  highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = {},        -- list of language that will be disabled
  },
  incremental_selection = {
      enable = true,
      disable = {},
      keymaps = {},
  },
  refactor = {
    highlight_defintions = {
      enable = true
    },
    smart_rename = {
      enable = false,
    },
    navigation = {
      enable = false,
    }
  },
  ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}

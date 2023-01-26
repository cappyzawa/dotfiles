return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "elm",
        "go",
        "hcl",
        "help",
        "html",
        "javascript",
        "json",
        "julia",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = function()
      local icons = {
        ui = require("config.icons").get("ui", true),
        diagnostics = require("config.icons").get("diagnostics", true),
      }
      return {
        options = {
          number = nil,
          modified_icon = icons.ui.Modified,
          buffer_close_icon = icons.ui.Close,
          left_trunc_marker = icons.ui.Left,
          right_trunc_marker = icons.ui.Right,
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 20,
          show_buffer_close_icons = false,
          show_buffer_icons = true,
          show_tab_indicators = true,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          separator_style = "thin",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              padding = 1,
            },
            {
              filetype = "lspsagaoutline",
              text = "Lspsaga Outline",
              text_align = "center",
              padding = 1,
            },
          },
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and icons.diagnostics.Error or icons.diagnostics.Warning
            -- return " " .. icon .. " " .. count
            return icon .. count
          end,
        },
        -- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
        -- Note: If you use catppuccin then modify the colors below!
        highlights = {},
      }
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
            ⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  
          ⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷ 
         ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ 
        ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ 
      ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ 
     ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ 
     ⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ 
     ⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ 
     ⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ 
     ⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ 
     ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ 
     ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ 
     ⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ 
      ⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ 
     ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            
  ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      return dashboard
    end,
  },
}

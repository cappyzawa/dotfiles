local colors = require("tokyonight.colors").setup({ style = "night" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "norcalli/nvim-colorizer.lua",
        config = function()
          require("colorizer").setup()
        end,
      },
    },
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
        "terraform",
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
 .d8888b. 8888888b.8888888888P888       888
d88P  Y88b888   Y88b     d88P 888   o   888
888    888888    888    d88P  888  d8b  888
888       888   d88P   d88P   888 d888b 888
888       8888888P"   d88P    888d88888b888
888    888888        d88P     88888P Y88888
Y88b  d88P888       d88P      8888P   Y8888
 "Y8888P" 888      d8888888888888P     Y888
  ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      return dashboard
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = {
        ui = require("config.icons").get("ui", false),
      }
      local mode_color = {
        n = colors.blue,
        i = colors.yellow,
        v = colors.purple,
        [""] = colors.purple,
        V = colors.purple,
      }
      return {
        sections = {
          lualine_a = {
            {
              function()
                return icons.ui.Devil
              end,
              color = function()
                return {
                  fg = mode_color[vim.fn.mode()],
                  bg = colors.bg,
                }
              end,
            },
          },
        },
      }
    end,
  },
}

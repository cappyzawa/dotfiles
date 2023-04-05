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
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "elm",
        "go",
        "hcl",
        "julia",
        "rego",
        "rust",
        "terraform",
      })
      return opts
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
    enabled = false,
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "folke/tokyonight.nvim" },
    },
    opts = function(_, opts)
      local icons = {
        ui = require("config.icons").get("ui", false),
      }

      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        [""] = colors.purple,
        V = colors.purple,
      }

      opts.sections = vim.tbl_extend("force", opts.sections, {
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
        lualine_y = { "progress" },
        lualine_z = { "location" },
      })
      return opts
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function(_, opts)
      opts.filetype_exclude = vim.list_extend(opts.filetype_exclude, { "lspsagafinder" })
    end,
  },
}

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
        "cue",
        "elm",
        "go",
        "gomod",
        "hcl",
        "julia",
        "rego",
        "rust",
        "starlark",
        "terraform",
      })
      return opts
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)

      -- additional config
      vim.treesitter.language.register("starlark", "tiltfile")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "folke/tokyonight.nvim" },
      { "ravitemer/mcphub.nvim" },
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
      table.insert(opts.sections.lualine_x, 3, require("mcphub.extensions.lualine"))
    end,
  },
}

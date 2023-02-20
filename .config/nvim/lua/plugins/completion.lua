return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "zbirenbaum/copilot-cmp" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local compare = require("cmp.config.compare")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "copilot" } }))
      opts.sorting = {
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          require("copilot_cmp.comparators").score,
          compare.offset,
          compare.exact,
          compare.score,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
          cmp = {
            enabled = true,
            method = "getCompletionsCycling",
          },
          panel = {
            -- if true, it can interfere with completions in copilot-cmp
            enabled = false,
          },
          suggestion = {
            -- if true, it can interfere with completions in copilot-cmp
            enabled = false,
          },
          filetypes = {
            ["dap-repl"] = false,
            terraform = false,
          },
        },
        config = function(_, opts)
          require("copilot").setup(opts)
        end,
      },
    },
    config = function(_, opts)
      require("copilot_cmp").setup(opts)
    end,
  },
}

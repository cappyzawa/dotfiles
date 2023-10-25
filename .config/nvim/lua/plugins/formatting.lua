return {
  {
    "stevearc/conform.nvim",
    opts = function()
      return {
        format = {
          timeout_ms = 5000,
        },
        formatters_by_ft = {
          css = { "prettier" },
          go = { "goimports" },
          html = { "prettier" },
          javascript = { "prettier" },
          json = { "prettier" },
          lua = { "stylua" },
          sh = { "shfmt" },
          typescript = { "prettier" },
          yaml = { "yamlfmt" },
          zsh = { "beautysh" },
        },
      }
    end,
  },
}

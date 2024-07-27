return {
  {
    "stevearc/conform.nvim",
    opts = function()
      return {
        default_format_opt = {
          timeout_ms = 5000,
        },
        formatters_by_ft = {
          css = { "prettier" },
          go = { "goimports", "gofumpt" },
          html = { "prettier" },
          javascript = { "prettier" },
          json = { "prettier" },
          -- json5 = { "prettier" },
          lua = { "stylua" },
          markdown = { "prettier" },
          rust = { "rustfmt" },
          sh = { "shfmt" },
          terraform = { "terraform_fmt" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          yaml = { "yamlfmt" },
          zsh = { "beautysh" },
        },
      }
    end,
  },
}

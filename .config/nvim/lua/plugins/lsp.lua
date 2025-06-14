return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "nvimdev/lspsaga.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      local function map(lhs, rhs, opts)
        local desc = opts and opts.desc or ""
        local has = opts and opts.has or ""
        keys[#keys + 1] = { lhs, rhs, desc = desc, { has = has } }
      end

      map("K", false)
      map("gk", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover", has = "lsp_hover" })

      opts.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      }

      opts.inlay_hints = {
        enable = false,
      }

      opts.format = {
        timeout_ms = 10000,
      }

      opts.servers.bashls = {
        filetypes = { "sh", "zsh", "bash" },
      }
      opts.servers.html = {}
      opts.servers.cssls = {}
      opts.servers.tilt_ls = {}
      opts.servers.gopls.settings.gopls.buildFlags = { "-tags=unit" }

      opts.servers.regal = nil

      return opts
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "beautysh",
        "cueimports",
        "flake8",
        "golangci-lint",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}

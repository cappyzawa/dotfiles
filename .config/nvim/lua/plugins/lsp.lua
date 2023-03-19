return {
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    event = "BufReadPre",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "glepnir/lspsaga.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      local function map(lhs, rhs, opts)
        local desc = opts and opts.desc or ""
        local has = opts and opts.has or ""
        keys[#keys + 1] = { lhs, rhs, desc = desc, { has = has } }
      end

      keys[#keys + 1] = { "gH", "<cmd>echo 'hello'<cr>", desc = "Hello" }
      map("gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Defenition" })
      map("gr", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
      map("gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Defenition" })
      map("gh", "<cmd>Lspsaga lsp_finder<CR>", { desc = "Lsp Finder" })
      map("K", vim.NIL)
      map("gk", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover" })
      map("gK", "<cmd>Lspsaga signature_help<CR>", { desc = "Signature Help", has = "signatureHelp" })
      map("g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
      map("g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
      map("go", "<cmd>Lspsaga outline<CR>", { desc = "Show Outline" })
      map("<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show Line Diagnostics" })
      map("<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show Cursor Diagnostics" })
    end,
    opts = {
      format = {
        timeout_ms = 10000,
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              usePlaceholders = true,
              analyses = {
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusewrites = true,
              },
            },
          },
        },
        jsonls = {
          flags = { debounce_text_changes = 500 },
          settings = {
            json = {
              -- Schemas https://www.schemastore.org
              schemas = {
                {
                  fileMatch = { "package.json" },
                  url = "https://json.schemastore.org/package.json",
                },
                {
                  fileMatch = { "tsconfig*.json" },
                  url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                  fileMatch = {
                    ".prettierrc",
                    ".prettierrc.json",
                    "prettier.config.json",
                  },
                  url = "https://json.schemastore.org/prettierrc.json",
                },
                {
                  fileMatch = { ".eslintrc", ".eslintrc.json" },
                  url = "https://json.schemastore.org/eslintrc.json",
                },
                {
                  fileMatch = {
                    ".babelrc",
                    ".babelrc.json",
                    "babel.config.json",
                  },
                  url = "https://json.schemastore.org/babelrc.json",
                },
                {
                  fileMatch = { "lerna.json" },
                  url = "https://json.schemastore.org/lerna.json",
                },
                {
                  fileMatch = {
                    ".stylelintrc",
                    ".stylelintrc.json",
                    "stylelint.config.json",
                  },
                  url = "http://json.schemastore.org/stylelintrc.json",
                },
                {
                  fileMatch = { "/.github/workflows/*" },
                  url = "https://json.schemastore.org/github-workflow.json",
                },
              },
            },
          },
        },
        rust_analyzer = {},
        terraformls = {},
        tsserver = {},
        elmls = {},
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = { "*.yaml" },
                ["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
              },
            },
          },
        },
        bashls = {
          filetypes = { "sh", "zsh", "bash" },
        },
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            -- "yaml",
            -- "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
          },
        }),
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.shfmt,
        nls.builtins.diagnostics.shellcheck,
      })
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "flake8",
        "prettier",
      },
    },
  },
}

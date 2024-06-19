local solargraph = require("lspconfig.server_configurations.solargraph")
return {
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
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
      { "nvimdev/lspsaga.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      local function map(lhs, rhs, opts)
        local desc = opts and opts.desc or ""
        local has = opts and opts.has or ""
        keys[#keys + 1] = { lhs, rhs, desc = desc, { has = has } }
      end

      map("gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Defenition" })
      map("gr", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
      map("gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Defenition" })
      map("gh", "<cmd>Lspsaga finder<CR>", { desc = "Lsp Finder" })
      map("gi", "<cmd>Lspsaga finder imp<CR>", { desc = "Goto Implementation" })
      map("K", false)
      map("gk", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover" })
      map("gK", "<cmd>Lspsaga signature_help<CR>", { desc = "Signature Help", has = "signatureHelp" })
      map("g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
      map("g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
      map("go", "<cmd>Lspsaga outline<CR>", { desc = "Show Outline" })
      map("<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show Line Diagnostics" })
      map("<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show Cursor Diagnostics" })

      return {
        diagnostics = {
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
        },
        format = {
          timeout_ms = 10000,
        },
        inlay_hints = {
          enabled = false,
        },
        codelens = {
          enabled = false,
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
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
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
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                cargo = {
                  buildScripts = {
                    enable = true,
                  },
                },
                procMacro = {
                  enable = true,
                },
              },
            },
          },
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
          dockerls = {},
          dagger = {},
          lua_ls = {
            Lua = {
              hint = {
                enable = true,
              },
            },
          },
          html = {},
          cssls = {},
          solargraph = {},
          tilt_ls = {},
          ruby_lsp = {},
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "beautysh",
        "cueimports",
        "flake8",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}

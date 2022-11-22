local vim = vim
local keymap = vim.keymap.set

local override_keymap_with_lspsaga = function(opts)
  local saga_path = vim.fn.stdpath('data') ..
      '/site/pack/packer/start/lspsaga.nvim'
  if vim.fn.empty(vim.fn.glob(saga_path)) > 0 then return end

  -- saga settings {{{
  local saga = require 'lspsaga'
  local saga_opt = {
    diagnostic_header = {
      vim.g.e_sign,
      vim.g.w_sign,
      vim.g.i_sign,
      vim.g.h_sign,
    },
    finder_action_keys = {
      scroll_down = '<C-j>',
      scroll_up = '<C-k>',
      open = 'e',
      vsplit = '\\',
      split = '-'
    },
    symbol_in_winbar = {
      in_custom = true,
    },
  }
  saga.init_lsp_saga(saga_opt)
  -- }}}

  keymap('n', 'gh', [[<cmd>Lspsaga lsp_finder<CR>]], opts)
  keymap('n', '<Leader>ca', [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]], opts)
  keymap({ "n", "v" }, '<Leader>ca', [[<cmd>Lspsaga code_action<CR>]], opts)
  keymap('n', 'gk', [[<cmd>Lspsaga hover_doc<CR>]], opts)
  keymap("n", "gp", [[<cmd>Lspsaga peek_definition<CR>]], opts)
  keymap("n", "go", [[<cmd>LSoutlineToggle<CR>]], opts)
  -- keymap('n', 'gK',
  --   [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
  --   opts)
  keymap('n', 'gt', [[<cmd>Lspsaga rename<CR>]], opts)
  keymap('n', '<C-j>',
    [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
    opts)
  keymap('n', '<C-k>',
    [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
    opts)
  keymap('n', 'sd', [[<cmd>Lspsaga show_line_diagnostics<CR>]], opts)
  keymap('n', '[d', [[<cmd>Lspsaga diagnostic_jump_prev<CR>]], opts)
  keymap('n', ']d', [[<cmd>Lspsaga diagnostic_jump_next<CR>]], opts)
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  -- diagnostics
  local diag_config = {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = { spacing = 4, prefix = "" },
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = true,
    -- Disable a feature
    update_in_insert = false,
    severity_sort = true
  }

  local signs = {
    Error = vim.g.e_sign,
    Warn = vim.g.w_sign,
    Hint = vim.g.h_sign,
    Info = vim.g.i_sign
  }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
    diag_config)

  -- hilight
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { test = icon, texthl = hl, numhl = "" })
  end

  -- keymap
  local opts = { noremap = true, silent = true }
  keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap('n', 'gt', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
    opts)
  keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
    opts)
  keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    opts)

  override_keymap_with_lspsaga(opts)
end
local lspconfig = require 'lspconfig'
local lsp_installer_servers = require 'nvim-lsp-installer.servers'
local installed_lsp_servers = vim.fn.stdpath('data') .. '/lsp_servers'
local lsputil = require 'lspconfig/util'

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol
  .make_client_capabilities())

-- lua {{{
local ok, sumneko_lua = lsp_installer_servers.get_server("sumneko_lua")
if ok then if not sumneko_lua:is_installed() then sumneko_lua:install() end end
local sumneko_root_path = installed_lsp_servers ..
    '/sumneko_lua/extension/server/bin'
local sumneko_binary = sumneko_root_path .. "/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lua_lsp_config = {
  cmd = { sumneko_binary, "--preview" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false }
    }
  }
}
-- }}}

-- go {{{
local go_lsp_config = {
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true
    },
    go = "go1.18",
  }
}
-- }}}

-- rust {{{
-- https://rust-analyzer.github.io/manual.html#nvim-lsp
local rust_lsp_config = {
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
        enable = true
      },
    }
  }
}
-- }}}

-- docker {{{
local ok, dockerls = lsp_installer_servers.get_server("dockerls")
if ok then if not dockerls:is_installed() then dockerls:install() end end
local dockerls_binary = installed_lsp_servers ..
    '/dockerfile/node_modules/.bin/docker-langserver'
local docker_lsp_config = { cmd = { dockerls_binary, "--stdio" } }
-- }}}

-- yaml {{{
local ok, yamlls = lsp_installer_servers.get_server("yamlls")
if ok then if not yamlls:is_installed() then yamlls:install() end end
local yamlls_binary = installed_lsp_servers ..
    '/yaml/node_modules/.bin/yaml-language-server'
local yaml_lsp_config = {
  cmd = { yamlls_binary, "--stdio" },
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
        ["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
        ["https://raw.githubusercontent.com/spion/concourse-jsonschema-generator/main/schema.json"] = "/pipeline.yml",
      },
      trace = { server = "verbose" }
    }
  }
}
-- }}}

-- bash {{{
local ok, bashls = lsp_installer_servers.get_server("bashls")
if ok then if not bashls:is_installed() then bashls:install() end end
local bashls_binary = installed_lsp_servers ..
    '/bash/node_modules/.bin/bash-language-server'
local bash_lsp_config = {
  cmd = { bashls_binary, "start" },
  filetypes = { "sh", "bash", "zsh" }
}
-- }}}

-- deno {{{
local deno_lsp_config = {
  root_dir = lsputil.root_pattern("deps.ts", "dev_deps.ts", "mod.ts")
}
-- }}}

-- ts {{{
local ok, tsserver = lsp_installer_servers.get_server("tsserver")
if ok then if not tsserver:is_installed() then tsserver:install() end end
local tsserver_binary = installed_lsp_servers ..
    '/tsserver/node_modules/.bin/typescript-language-server'
local ts_lsp_config = {
  cmd = { tsserver_binary, "--stdio" },
  root_dir = lsputil.root_pattern("package.json", "package-lock.json",
    "yarh-lock.json")
}
-- }}}

-- java {{{
local java_lsp_binary = os.getenv("HOME") ..
    '/.local/share/zinit/plugins/georgewfraser---java-language-server/dist/lang_server_mac.sh'
lspconfig.java_language_server.setup { cmd = { "bash", java_lsp_binary } }
-- }}}

-- json {{{
local ok, jsonls = lsp_installer_servers.get_server("jsonls")
if ok then if not jsonls:is_installed() then jsonls:install() end end
local jsonls_binary = installed_lsp_servers ..
    '/jsonls/node_modules/.bin/vscode-json-language-server'
local json_lsp_config = { cmd = { jsonls_binary, "--stdio" } }
-- }}}

-- python {{{
local ok, pylsp = lsp_installer_servers.get_server("pylsp")
if ok then if not pylsp:is_installed() then pylsp:install() end end
local pylsp_binary = installed_lsp_servers .. '/pylsp/venv/bin/pylsp'
local python_lsp_config = { cmd = { pylsp_binary } }
-- }}}

-- clang {{{
local ok, clangd = lsp_installer_servers.get_server("clangd")
if ok then if not clangd:is_installed() then clangd:install() end end
local clangd_binary = installed_lsp_servers .. '/clangd/clangd'
local clang_lsp_config = { cmd = { clangd_binary, "--background-index" } }
-- }}}

-- julia {{{
-- }}}

-- efm {{{
local ok, efmls = lsp_installer_servers.get_server("efmls")
if ok then if not efmls:is_installed() then efmls:install() end end
local efmls_binary = installed_lsp_servers .. '/efm/efm-langserver'
local efm_lsp_config = {
  cmd = { efmls_binary, '-logfile', '/tmp/efm.log', '-loglevel', '5' },
  filetypes = { "rego", "sh" },
  init_options = {
    documentFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true
  }
}
-- }}}

-- ansible {{{
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*/playbooks/*.yml,*/roles/*.yml',
  callback = function()
    vim.opt.filetype = 'yaml.ansible'
  end,
})

local ok, ansiblels = lsp_installer_servers.get_server("ansiblels")
if ok then if not ansiblels:is_installed() then ansiblels:install() end end
local ansiblels_binary = installed_lsp_servers .. '/ansiblels/bin/ansible-language-server'
local ansiblels_config = { cmd = { ansiblels_binary, "--stdio" } }
-- }}}

-- html {{{
local ok, htmlls = lsp_installer_servers.get_server("html")
if ok then if not htmlls:is_installed() then jsonls:install() end end
local htmlls_binary = installed_lsp_servers ..
    '/html/node_modules/.bin/vscode-html-language-server'
local htmlls_config = {
  filetype = { "html" },
  cmd = { htmlls_binary, "--stdio" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
}
-- }}}

-- css {{{
local ok, cssls = lsp_installer_servers.get_server("css")
if ok then if not cssls:is_installed() then jsonls:install() end end
local cssls_binary = installed_lsp_servers ..
    '/cssls/node_modules/.bin/vscode-css-language-server'
local cssls_config = {
  filetype = { "css", "scss", "less" },
  cmd = { cssls_binary, "--stdio" },
  settings = {
    css = {
      validate = true
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    }
  },
}
-- }}}

local servers = {
  sumneko_lua = lua_lsp_config,
  vimls = {},
  terraformls = {},
  elmls = {},
  ansiblels = ansiblels_config,
  gopls = go_lsp_config,
  rust_analyzer = rust_lsp_config,
  nimls = {},
  dockerls = docker_lsp_config,
  yamlls = yaml_lsp_config,
  bashls = bash_lsp_config,
  jsonls = json_lsp_config,
  denols = deno_lsp_config,
  tsserver = ts_lsp_config,
  zls = {},
  pylsp = python_lsp_config,
  clangd = clang_lsp_config,
  solargraph = {},
  julials = {},
  efm = efm_lsp_config,
  html = htmlls_config,
  cssls = cssls_config
}

for ls, config in pairs(servers) do
  lspconfig[ls].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    before_init = config.before_init,
    cmd = config.cmd,
    init_options = config.init_options,
    filetypes = config.filetypes,
    root_dir = config.root_dir,
    settings = config.settings
  }
end

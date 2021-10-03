local vim = vim

vim.lsp.set_log_level("info")

--- icons
vim.g.w_sign = ""
vim.g.e_sign = ""
vim.g.h_sign = "ﯦ"

local override_keymap_with_lspsaga = function(opts)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local saga_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/lspsaga.nvim'
	if vim.fn.empty(vim.fn.glob(saga_path)) > 0 then
		return
	end

	-- saga settings {{{
	local saga = require'lspsaga'
	local saga_opt = {
		error_sign = vim.g.e_sign,
		warn_sign = vim.g.w_sign,
		hint_sign = vim.g.h_sign,
		finder_action_keys = {
			scroll_down = '<C-j>',
			scroll_up = '<C-k>',
		}
	}
	saga.init_lsp_saga(saga_opt)
	-- }}}

	buf_set_keymap('n', 'gh', [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], opts)
	-- buf_set_keymap('n', '<Leader>ca', [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]], opts)
	-- buf_set_keymap('v', '<Leader>ca', [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]], opts)
	-- buf_set_keymap('n', 'gk', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]], opts)
  -- buf_set_keymap('n', 'gK', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]], opts)
  buf_set_keymap('n', 'gt', [[<cmd>lua require('lspsaga.rename').rename()<CR>]], opts)
  -- buf_set_keymap('n', 'gd', [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], opts)
  -- buf_set_keymap('n', '<C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], opts)
  -- buf_set_keymap('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], opts)
  -- buf_set_keymap('n', '[d', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]], opts)
  -- buf_set_keymap('n', ']d', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]], opts)
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- diagnostics
  local diag_config = {
      -- Enable underline, use default values
      underline = true,
      -- Enable virtual text, override spacing to 4
      virtual_text = {
        spacing = 4,
        prefix = "",
      },
      -- Use a function to dynamically turn signs off
      -- and on, using buffer local variables
      signs = true,
      -- Disable a feature
      update_in_insert = false,
      severity_sort = true,
  }

  local signs = {
    Error = vim.g.e_sign,
    Warn = vim.g.w_sign,
    Hint = vim.g.h_sign,
    Info = vim.g.h_sign,
  }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    diag_config
  )

  -- hilight
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign"..type
    vim.fn.sign_define(hl, { test = icon, texthl = hl, numhl = "" })
  end

  -- keymap
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	override_keymap_with_lspsaga(opts)
end
local lspconfig = require'lspconfig'
local lspcontainers = require'lspcontainers'
local lsputil = require'lspconfig/util'

local cmp_nvim_lsp = require'cmp_nvim_lsp'
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

--lua {{{
local lua_lsp_config = {
  cmd = lspcontainers.command('sumneko_lua'),
}
-- }}}

--go {{{
local go_lsp_config = {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}
-- }}}

-- docker {{{
local docker_lsp_config = {
  before_init = function (params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('dockerls')
}
-- }}}

-- yaml {{{
local yaml_lsp_config = {
  before_init = function (params)
    params.processId = vim.NIL
  end,
  settings = {
    yaml = {
      schemaStore = {
        enable = true
      },
      schemas = {
        kubernetes = "/*.yaml";
        ["http://json.schemastore.org/kustomization"] = "/kustomization.yaml";
        ["https://raw.githubusercontent.com/cappyzawa/concourse-pipeline-jsonschema/master/concourse_jsonschema.json"] = "/pipeline.yml";
      },
      trace = {
        server = "verbose"
      },
    }
  }
}
-- }}}

-- bash {{{
local bash_lsp_config = {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('bashls'),
  filetypes = {"sh", "bash", "zsh"}
}
-- }}}

-- deno {{{
local deno_lsp_config = {
  root_dir = lsputil.root_pattern("deps.ts", "dev_deps.ts", "mod.ts")
}
-- }}}

-- ts {{{
local ts_lsp_config = {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('tsserver'),
  root_dir = lsputil.root_pattern("package.json", "package-lock.json", "yarh-lock.json")
}
-- }}}

-- json {{{
local json_lsp_config = {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('jsonls'),
}
-- }}}

-- python {{{
local python_lsp_config = {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('pylsp'),
}
-- }}}

-- clang {{{
local clang_lsp_config = {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('clangd'),
}
-- }}}

--julia {{{
lspconfig.julials.setup{
    on_attach = on_attach,
    -- capabilities = capabilities,
    on_new_config = function(new_config,new_root_dir)
      cmd = {
        "julia",
        "--startup-file=no",
        "--history-file=no",
        "-e", [[
          using Pkg;
          Pkg.instantiate()
          using LanguageServer; using SymbolServer;
          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
          project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
          # Make sure that we only load packages from this environment specifically.
          @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
          server.runlinter = true;
          run(server);
        ]]
      };
      new_config.cmd = cmd
    end
}
-- }}}

--elm {{{
local custom_attach = function(client)
  on_attach(client)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

lspconfig.elmls.setup({
  on_attach = custom_attach;
  -- capabilities = capabilities,
})
vim.cmd([[ autocmd BufWritePre *.elm lua vim.lsp.buf.formatting() ]])
-- }}}

local servers = {
  sumneko_lua = lua_lsp_config,
  vimls = {},
  terraformls = {},
  gopls = go_lsp_config,
  rust_analyzer = {},
  nimls = {},
  dockerls = docker_lsp_config,
  yamlls = yaml_lsp_config,
  bashls = bash_lsp_config,
  denols = deno_lsp_config,
  tsserver = ts_lsp_config,
  pylsp = python_lsp_config,
  clangd = clang_lsp_config,
  solargraph = {},
}

for ls, config in pairs(servers) do
  lspconfig[ls].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    before_init = config.before_init,
    cmd = config.cmd,
    filetypes = config.filetypes,
    root_dir = config.root_dir,
    settings = config.settings,
  }
end

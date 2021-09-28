local vim = vim

-- dignostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
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
    update_in_insert = true,
  }
)

--- icons
vim.g.w_sign = ""
vim.g.e_sign = ""
vim.g.h_sign = "ﯦ"

--- hilight
vim.fn.sign_define("DiagnosticSignError", {text = vim.g.e_sign, texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = vim.g.w_sign, texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignHint", {text = vim.g.h_sign, texthl = "DiagnosticSignHint"})

-- attach {{{
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  -- keymap {{{
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --- }}}
end
--- }}}

-- keymap {{{
-- local keymap_lsp_func = {
--   gd = "vim.lsp.buf.definition()",
--   gp = "require'lspsaga.provider'.preview_definition()",
--   gi = "vim.lsp.buf.implementation()",
--   gk = "require'lspsaga.hover'.render_hover_doc()",
--   gk = "vim.lsp.buf.hover()",
--   ["<C-j>"] = "require'lspsaga.action'.smart_scroll_with_saga(1)",
--   ["<C-k>"] = "require'lspsaga.action'.smart_scroll_with_saga(-1)",
--   gr = "vim.lsp.buf.references()",
--   gt = "vim.lsp.buf.rename()",
--   gh = "require'lspsaga.provider'.lsp_finder()",
--   ca = "require'lspsaga.codeaction'.code_action()",
--   ["[e"] = "require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()",
--   ["]e"] = "require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()",
--   cc = "require'lspsaga.diagnostic'.show_line_diagnostics()",
--   et = "require'lspsaga.floaterm'.open_float_terminal()",
--   qt = "require'lspsaga.floaterm'.close_float_terminal()",
--   ["<Leader>x"] = "require'lspsaga.floaterm'.open_float_terminal('lazygit')"
-- }
-- }}}

local lspconfig = require'lspconfig'
local lspcontainers = require'lspcontainers'
local configs = require'lspconfig/configs'
local lsputil = require'lspconfig/util'

--lua {{{
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = lspcontainers.command('sumneko_lua'),
}
-- }}}

--vim {{{
lspconfig.vimls.setup{
  on_attach = on_attach,
}
-- }}}

--julia {{{
lspconfig.julials.setup{
    on_attach = on_attach,
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

--terraform {{{
lspconfig.terraformls.setup{
  on_attach = on_attach,
}
-- }}}

--go {{{
function goimports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end
vim.cmd([[ autocmd BufWritePre *.go lua goimports(1000) ]])

lspconfig.gopls.setup {
  on_attach = on_attach,
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

--rust {{{
lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
  cmd = {"rust-analyzer"},
}
-- }}}

--nim {{{
lspconfig.nimls.setup{
  on_attach = on_attach,
}
-- }}}

--docker {{{
lspconfig.dockerls.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('dockerls'),
}
-- }}}

--yaml {{{
lspconfig.yamlls.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('yamlls'),
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

--elm {{{
local custom_attach = function(client)
  on_attach(client)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

lspconfig.elmls.setup({
  on_attach = custom_attach;
})
vim.cmd([[ autocmd BufWritePre *.elm lua vim.lsp.buf.formatting() ]])
-- }}}

--bash {{{
lspconfig.bashls.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('bashls'),
  filetypes = {"sh", "bash", "zsh"}
}
-- }}}

--deno {{{
lspconfig.denols.setup{
  on_attach = on_attach,
  root_dir = lsputil.root_pattern("deps.ts", "dev_deps.ts", "mod.ts")
}
-- }}}

--typescript {{{
lspconfig.tsserver.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('tsserver'),
  root_dir = lsputil.root_pattern("package.json", "package-lock.json", "yarh-lock.json")
}
-- }}}

-- json {{{
lspconfig.jsonls.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('jsonls'),
}
-- }}}

--python {{{
lspconfig.pylsp.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = lspcontainers.command('pylsp'),
}
-- }}}

-- clang {{{
lspconfig.clangd.setup{
  on_attach = on_attach,
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = require'lspcontainers'.command('clangd'),
}
-- }}}

-- ruby {{{
lspconfig.solargraph.setup{
  on_attach = on_attach,
}
-- }}}

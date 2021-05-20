local vim = vim

-- dignostic
vim.lsp.diagnostic.set_signs()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 4,
      prefix = "",
    },

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)

---- icons
vim.g.w_sign = ""
vim.g.e_sign = "⚡"
vim.g.h_sign = "ﯦ"

---- hilight
vim.fn.sign_define("LspDiagnosticsSignError", {text = vim.g.e_sign, texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = vim.g.w_sign, texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = vim.g.h_sign, texthl = "LspDiagnosticsSignHint"})

-- keymap
local keymap_lsp_func = {
  gd = "vim.lsp.buf.definition()",
  gp = "require'lspsaga.provider'.preview_definition()",
  gi = "vim.lsp.buf.implementation()",
  gk = "require'lspsaga.hover'.render_hover_doc()",
  ["<C-j>"] = "require'lspsaga.hover'.smart_scroll_hover(1)",
  ["<C-k>"] = "require'lspsaga.hover'.smart_scroll_hover(-1)",
  gr = "vim.lsp.buf.references()",
  gt = "require'lspsaga.rename'.rename()",
  gh = "require'lspsaga.provider'.lsp_finder()",
  ca = "require'lspsaga.codeaction'.code_action()",
  ["[e"] = "require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()",
  ["]e"] = "require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()",
  et = "require'lspsaga.floaterm'.open_float_terminal()",
  qt = "require'lspsaga.floaterm'.close_float_terminal()",
  ["<Leader>x"] = "require'lspsaga.floaterm'.open_float_terminal('lazygit')"
}

local opts = { noremap=true, silent=true }
for k, v in pairs(keymap_lsp_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd>lua %s<CR>", v), opts)
end

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

--lua
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end
local sumneko_root_path = vim.fn.expand('$HOME')..'/.zinit/plugins/sumneko---lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

--vim
lspconfig.vimls.setup{}

--julia
lspconfig.julials.setup{
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

--terraform
lspconfig.terraformls.setup{}

--go
function goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = "textDocument/codeAction"
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end

  vim.lsp.buf.formatting()
end
vim.cmd([[ autocmd BufWritePre *.go lua goimports(1000) ]])

lspconfig.gopls.setup{
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        }
    }
}

--rust
lspconfig.rust_analyzer.setup{
  cmd = {"rust-analyzer"},
  settings = {
      ["rust-analyzer"] = {
          assist = {
              importMergeBehavior = "last",
              importPrefix = "by_self",
          },
          cargo = {
              loadOutDirsFromCheck = true
          },
          procMacro = {
              enable = true
          },
      }
  }
}

--nim
lspconfig.nimls.setup{}

--docker
lspconfig.dockerls.setup{
  cmd = {"docker-langserver", "--stdio"}
}

--yaml
lspconfig.yamlls.setup{
  cmd = {"yaml-language-server", "--stdio"},
  settings = {
    yaml = {
      schemaStore = {
        enable = true
      },
      schemas = {
        kubernetes = "/*.yaml";
        ["http://json.schemastore.org/kustomization"] = "/kustomization.yaml";
        ["https://raw.githubusercontent.com/cappyzawa/concourse-pipeline-jsonschema/master/concourse_jsonschema.json"] = "/pipeline.yml";
      }
    }
  }
}

--elm
local custom_attach = function(client)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

lspconfig.elmls.setup({
  on_attach = custom_attach;
})
vim.cmd([[ autocmd BufWritePre *.elm lua vim.lsp.buf.formatting() ]])

--deno
lspconfig.denols.setup{}

--bash
lspconfig.bashls.setup{
  filetypes = {"sh", "bash", "zsh"}
}

--typescript
lspconfig.tsserver.setup{}

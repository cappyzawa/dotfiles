local vim = vim

vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]

-- dignostic
vim.lsp.diagnostic.set_signs()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 4,
      prefix = "廓",
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
local w_sign = ""
local e_sign = ""
local h_sign = "ﯦ"

---- hilight
vim.fn.sign_define("LspDiagnosticsSignError", {text = e_sign, texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = w_sign, texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = h_sign, texthl = "LspDiagnosticsSignHint"})

vim.cmd [[highlight! link LspDiagnosticsDefaultError Red]]
vim.cmd [[highlight! link LspDiagnosticsDefaultWarning Yellow]]
vim.cmd [[highlight! link LspDiagnosticsDefaultHint Green]]
vim.cmd [[highlight! link LspDiagnosticsDefaultInfomation Grey]]

-- completion
local completion_chain_complete_list = {
  {
    ["complete_items"] = {"lsp", "path", "buffer"},
  }
}
vim.api.nvim_set_var("completion_chain_complete_list", completion_chain_complete_list)

-- keymap
local keymap_lsp_func = {
  gd = "definition()",
  gi = "implementation()",
  gk = "hover()",
  gr = "references()",
  gt = "rename()"
}

local opts = { noremap=true, silent=true }
for k, v in pairs(keymap_lsp_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd>lua vim.lsp.buf.%s<CR>", v), opts)
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
      server_path = vim.fn.expand('$HOME').."/.julia/packages/LanguageServer/y1ebo/src/LanguageServer.jl/src"
      cmd = {
        "julia",
        "--project="..server_path,
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
lspconfig.terraformls.setup{
  cmd = {"terraform-ls", "serve"}
}

--go
lspconfig.gopls.setup{}

--rust
lspconfig.rust_analyzer.setup{
  cmd = {"rust-analyzer"}
}

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
lspconfig.elmls.setup{}

--bash
lspconfig.bashls.setup{
  filetypes = {"sh", "bash", "zsh"}
}

--typescript
lspconfig.tsserver.setup{}

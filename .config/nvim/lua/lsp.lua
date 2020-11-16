local vim = vim

vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
vim.cmd [[autocmd BufEnter * lua require'diagnostic'.on_attach()]]

-- dignostic
vim.api.nvim_set_var("diagnostic_enable_virtual_text", 1)
vim.api.nvim_set_var("diagnostic_virtual_text_prefix", "廓")
---- icons
local w_sign = ""
local e_sign = ""
local h_sign = "ﯦ"

---- hilight
vim.fn.sign_define("LspDiagnosticsErrorSign", {text = e_sign, texthl = "LspDiagnosticsError"})
vim.fn.sign_define("LspDiagnosticsWarningSign", {text = w_sign, texthl = "LspDiagnosticsWarning"})
vim.fn.sign_define("LspDiagnosticsHintSign", {text = h_sign, texthl = "LspDiagnosticsHint"})

vim.cmd [[highlight! link LspDiagnosticsError Red]]
vim.cmd [[highlight! link LspDiagnosticsWarning Yellow]]
vim.cmd [[highlight! link LspDiagnosticsHint Green]]
vim.cmd [[highlight! link LspDiagnosticsInfomation Grey]]

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
--lua-language-server is installed by nvim
lspconfig.sumneko_lua.setup{}

--vim
--vim-language-server is installed by nvim
lspconfig.vimls.setup{}

--julia
--LanguageServer.jl is installed by nvim
lspconfig.julials.setup{}

--terraform
lspconfig.terraformls.setup{}
-- if not lspconfig.terraform_lsp then
--   configs.terraform_lsp = {
--     default_config = {
--       cmd = {'terraform-lsp'};
--       filetypes = {'terraform'};
--       root_dir = function(fname)
--         return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
--       end;
--       settings = {};
--     };
--   }
-- end
-- lspconfig.terraform.setup{}

--go
lspconfig.gopls.setup{
  cmd = {"gopls"};
}

--rust
lspconfig.rust_analyzer.setup{
  cmd = {"rust-analyzer"}
}

--docker
--docker-langserver is installed by nvim
lspconfig.dockerls.setup{
  cmd = {"docker-langserver", "--stdio"}
}

--yaml
--yaml-language-server is installed by nvim
lspconfig.yamlls.setup{
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
--elm-language-server is installed by nvim
lspconfig.elmls.setup{}

--bash
--bash-language-server is installed by nvim
lspconfig.bashls.setup{
  filetypes = {"sh", "bash", "zsh"}
}

--typescript
--typescript-language-server is installed by nvim
lspconfig.tsserver.setup{}

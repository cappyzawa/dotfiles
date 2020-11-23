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
lspconfig.gopls.setup{}

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

local vim = vim

vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
vim.cmd [[autocmd BufEnter * lua require'diagnostic'.on_attach()]]

-- icons
local w_sign = ""
local e_sign = ""
local h_sign = "ﯦ"

-- hilight
vim.fn.sign_define("LspDiagnosticsErrorSign", {text = e_sign, texthl = "LspDiagnosticsError"})
vim.fn.sign_define("LspDiagnosticsWarningSign", {text = w_sign, texthl = "LspDiagnosticsWarning"})
vim.fn.sign_define("LspDiagnosticsHintSign", {text = h_sign, texthl = "LspDiagnosticsHint"})

-- dignostic
vim.api.nvim_set_var("diagnostic_enable_virtual_text", 1)
vim.api.nvim_set_var("diagnostic_virtual_text_prefix", "廓")

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

local nvim_lsp = require'nvim_lsp'
local configs = require'nvim_lsp/configs'
local util = require'nvim_lsp/util'

--lua
--lua-language-server is installed by nvim
nvim_lsp.sumneko_lua.setup{}

--vim
--vim-language-server is installed by nvim
nvim_lsp.vimls.setup{}

--julia
--LanguageServer.jl is installed by nvim
nvim_lsp.julials.setup{}

--terraform
-- terraformls does not work...
-- nvim_lsp.terraformls.setup{}
if not configs.terraformlsp then
  configs.terraformlsp = {
    default_config = {
      cmd = {'terraform-lsp'};
      filetypes = {'terraform'};
      root_dir = util.root_pattern(".terraform", ".git");
      settings = {};
    };
  }
end
nvim_lsp.terraformlsp.setup{}

--go
nvim_lsp.gopls.setup{
  cmd = {"gopls"};
}

--docker
--docker-langserver is installed by nvim
nvim_lsp.dockerls.setup{
  cmd = {"docker-langserver", "--stdio"}
}

--yaml
--yaml-language-server is installed by nvim
nvim_lsp.yamlls.setup{
  settings = {
    yaml = {
      schemaStore = {
        enable = true
      },
    }
  }
}

--elm
--elm-language-server is installed by nvim
nvim_lsp.elmls.setup{}

--bash
--bash-language-server is installed by nvim
nvim_lsp.bashls.setup{
  filetypes = {"sh", "bash", "zsh"}
}

--typescript
--typescript-language-server is installed by nvim
nvim_lsp.tsserver.setup{}

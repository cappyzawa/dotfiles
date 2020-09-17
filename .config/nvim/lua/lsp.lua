vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
vim.cmd [[autocmd BufEnter * lua require'diagnostic'.on_attach()]]

-- hilight
vim.fn.sign_define("LspDiagnosticsErrorSign", {text = "◉", texthl = "LspDiagnosticsError"})
vim.fn.sign_define("LspDiagnosticsWarningSign", {text = "◉", texthl = "LspDiagnosticsWarning"})

-- map
vim.cmd [[
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gk <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.rename()<CR>
]]

local nvim_lsp = require'nvim_lsp'

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
nvim_lsp.terraformls.setup{
  cmd = {"terraform-ls", "serve"};
}

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

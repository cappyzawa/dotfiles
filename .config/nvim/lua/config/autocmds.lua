-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt = vim.opt

-- tabstop,shiftwidth = 4 for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tab4", { clear = true }),
  pattern = { "elm" },
  callback = function()
    opt.tabstop = 4
    opt.shiftwidth = 4
  end,
})

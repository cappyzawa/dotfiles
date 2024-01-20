-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt = vim.opt

local function augroup(name)
  return vim.api.nvim_create_augroup("mylazyvim_" .. name, { clear = true })
end

-- tabstop,shiftwidth = 4 for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("tab4"),
  pattern = { "elm" },
  callback = function()
    opt.tabstop = 4
    opt.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("tiltfile"),
  pattern = {
    "Tiltfile*",
  },
  callback = function()
    vim.opt_local.filetype = "tiltfile"
  end,
})

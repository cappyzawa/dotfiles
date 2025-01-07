-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Esc
map("i", "jj", "<Esc>")
map("o", "jj", "<Esc>")

-- Move Lines
map("n", "<M-j>", ":m .+1<cr>==", { desc = "Move down" })
map("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("i", "<M-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
map("n", "<M-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<M-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- Move Cursor
map("n", "J", "10j")
map("n", "K", "10k")
map("v", "J", "10j")
map("v", "K", "10k")
map("n", "<leader>h", "^", { desc = "Move beginning of line" })
map("n", "<leader>l", "$", { desc = "Move end of line" })
map("v", "<leader>h", "^", { desc = "Move beginning of line" })
map("v", "<leader>l", "$", { desc = "Move end of line" })

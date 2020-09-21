local vim = vim

require'telescope.init'.setup{
  defaults = {
    vimgrep_arguments = {'rg', '-i', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
  }
}

local opts = { noremap=true, silent=true }
local keymap_telescope_func = {
  ["<Leader>ff"] = [[require'telescope.builtin'.find_files{find_command = {"rg", "-i", "--hidden", "--files", "-g", "!.git"}}]],
  ["<Leader>rg"] = "require'telescope.builtin'.live_grep()",
  ["<Leader>ch"] = "require'telescope.builtin'.command_history{}",
  ["<Leader>bl"] = [[require'telescope.builtin'.buffers{show_all_buffers = true}]]
}

for k, v in pairs(keymap_telescope_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd> lua %s<CR>", v), opts)
end

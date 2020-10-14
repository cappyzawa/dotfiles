local vim = vim

local actions = require'telescope.actions'

require'telescope.init'.setup{
  defaults = {
    vimgrep_arguments = {'rg', '-i', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.goto_file_selection_split,
      },
      n = {
        ["jj"] = actions.close,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.goto_file_selection_split,
      },
    }
  }
}

local opts = { noremap=true, silent=true }
local keymap_telescope_func = {
  ["<Leader>ff"] = [[require'telescope.builtin'.find_files{find_command = {"rg", "-i", "--hidden", "--files", "-g", "!.git"}}]],
  ["<Leader>rg"] = "require'telescope.builtin'.live_grep()",
  ["<Leader>ch"] = "require'telescope.builtin'.command_history{}",
  ["<Leader>bl"] = [[require'telescope.builtin'.buffers{show_all_buffers = true}]],
  ["gr"] = "require'telescope.builtin'.lsp_references{ shorten_path = true }",
}

for k, v in pairs(keymap_telescope_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd> lua %s<CR>", v), opts)
end

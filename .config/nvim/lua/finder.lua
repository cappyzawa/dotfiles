local vim = vim

local telescope = require'telescope'
local actions = require'telescope.actions'

-- extensions
telescope.load_extension('ghcli')

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.goto_file_selection_split,
        ["<c-v>"] = actions.goto_file_selection_vsplit
      },
      n = {
        ["jj"] = actions.close,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.goto_file_selection_split,
        ["<c-v>"] = actions.goto_file_selection_vsplit
      },
    }
  }
}

local opts = { noremap=true, silent=true }
local keymap_telescope_func = {
  ["<Leader>ff"] = "require'telescope.builtin'.find_files()",
  ["<Leader>rg"] = "require'telescope.builtin'.live_grep()",
  ["<Leader>ch"] = "require'telescope.builtin'.command_history{}",
  ["<Leader>bl"] = "require'telescope.builtin'.buffers{show_all_buffers = true}",
  ["<Leader>gi"] = "require'telescope.builtin'.gh_issues()",
  ["<Leader>gp"] = "require'telescope.builtin'.gh_pull_request()",
  ["<Leader>gst"] = "require'telescope.builtin'.git_status()",
  ["gr"] = "require'telescope.builtin'.lsp_references{ shorten_path = true }",
}

for k, v in pairs(keymap_telescope_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd> lua %s<CR>", v), opts)
end

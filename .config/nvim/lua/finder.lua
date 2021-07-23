local vim = vim

local telescope = require'telescope'
local actions = require'telescope.actions'

-- extensions
telescope.load_extension('gh')
telescope.load_extension('ghq')
telescope.load_extension('terraform')
telescope.setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--hidden',
    },
    file_ignore_patterns = {
      'node_modules',
      '.git',
    },
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical,
      },
      n = {
        ["jj"] = actions.close,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical
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
  ["<Leader>gi"] = "require'telescope'.extensions.gh.issues()",
  ["<Leader>gp"] = "require'telescope'.extensions.gh.pull_request()",
  ["<Leader>ghq"] = "require'telescope'.extensions.ghq.list()",
  ["<Leader>gst"] = "require'telescope.builtin'.git_status()",
  ["<Leader>p"] = "require'telescope.builtin'.registers()",
  ["<Leader>ej"] = "require'telescope.builtin'.symbols{ sources = {'emoji'} }",
  ["<Leader>gj"] = "require'telescope.builtin'.symbols{ sources = {'gitmoji'} }",
  ["<Leader>mj"] = "require'telescope.builtin'.symbols{ sources = {'math'} }",
  ["gr"] = "require'telescope.builtin'.lsp_references{ shorten_path = true }",
  ["gi"] = "require'telescope.builtin'.lsp_implementations()",
}

for k, v in pairs(keymap_telescope_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd> lua %s<CR>", v), opts)
end

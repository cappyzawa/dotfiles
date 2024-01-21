local icons = {
  diagnostics = require("config.icons").get("diagnostics", true),
  git = require("config.icons").get("git", true),
  kind = require("config.icons").get("kind", true),
  type = require("config.icons").get("type", true),
  ui = require("config.icons").get("ui", true),
}

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "rcarriga/nvim-notify",
        keys = {
          { "<Leader>no", "<cmd>Telescope notify<cr>", desc = "Show notifications" },
        },
        config = function()
          require("telescope").load_extension("notify")
        end,
      },
    },
    opts = function()
      local Util = require("lazyvim.util")
      local actions = require("telescope.actions")
      local action_utils = require("telescope.actions.utils")
      local action_state = require("telescope.actions.state")

      local select_one_or_multi = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          actions.close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format("%s %s", "edit", j.path))
            end
          end
        else
          actions.select_default(prompt_bufnr)
        end
      end

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
      end
      return {
        defaults = {
          prompt_prefix = icons.ui.Telescope,
          selection_caret = icons.ui.ChevronRight,
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<cr>"] = select_one_or_multi,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },
  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    opts = {
      ft_blocklist = {
        "bash",
        "elm",
        "go",
        "lua",
        "markdown",
        "rust",
        "sh",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    keys = {
      { "<F12>", "<cmd>MarkdownPreview<cr>", desc = "Preview Markdown file" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    config = true,
  },
}

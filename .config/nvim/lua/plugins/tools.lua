return {
  {
    "tyru/open-browser-github.vim",
    cmd = "OpenGithubFile",
    dependencies = {
      { "tyru/open-browser.vim" },
    },
  },
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    keys = { "<leader>gm", "<cmd>GitMessenger<CR>", desc = "Show Git Message" },
    config = function()
      vim.g.git_messenger_include_diff = "current"
      vim.g.git_messenger_always_into_popup = true
      vim.g.git_messenger_no_default_mappings = true
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT" },
    config = function()
      require("chatgpt").setup({})
    end,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
  },
}

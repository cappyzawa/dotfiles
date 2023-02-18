return {
  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    opts = {
      disable = {
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
}

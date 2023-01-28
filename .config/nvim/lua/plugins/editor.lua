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
        "yaml",
      },
    },
  },
}

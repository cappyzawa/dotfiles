return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      terminal = {
        win = {
          relative = "editor",
          position = "float",
          width = 0.8,
          height = 0.7,
          row = 0.1,
          col = 0.1,
          border = "rounded",
        },
      },
    },
    keys = {
      {
        "<leader>tt",
        function()
          Snacks.terminal.toggle()
        end,
        desc = "Toggle Terminal",
        mode = { "n", "t" },
      },
    },
  },
}

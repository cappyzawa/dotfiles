local config = require("config.completion")

return {
  {
    "glepnir/lspsaga.nvim",
    event = "BufReadPre",
    config = config.lspsaga,
    branch = "0.2.4",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "onsails/lspkind.nvim" },
      { "zbirenbaum/copilot-cmp" },
      { "lukas-reineke/cmp-under-comparator" },
    },
    config = require("config.completion").cmp,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = config.copilot,
      },
    },
    config = function(_, opts)
      require("copilot_cmp").setup(opts)
    end,
  },
}

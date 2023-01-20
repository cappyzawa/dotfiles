local lang = {}
local conf = require("modules.lang.config")

lang["iamcco/markdown-preview.nvim"] = {
    opt = true,
    ft = "markdown",
    run = "cd app && yarn install",
}
lang["simrat39/rust-tools.nvim"] = {
    opt = true,
    ft = "rust",
    config = conf.rust_tools,
    requires = "nvim-lua/plenary.nvim",
}
return lang

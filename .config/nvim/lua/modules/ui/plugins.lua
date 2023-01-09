local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { opt = false }
ui["folke/tokyonight.nvim"] = { opt = false, config = conf.tokyonight }
ui["rcarriga/nvim-notify"] = {
    opt = false,
    config = conf.notify,
}
ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    after = { "nvim-lspconfig", "tokyonight.nvim" },
    config = conf.lualine,
}
ui["nvim-tree/nvim-tree.lua"] = {
    opt = true,
    cmd = {
        "NvimTreeToggle",
        "NvimTreeOpen",
        "NvimTreeFindFile",
        "NvimTreeFindFileToggle",
        "NvimTreeRefresh",
    },
    config = conf.nvim_tree,
    requires = {
        "s1n7ax/nvim-window-picker",
        opt = true,
        tag = "v1.*",
        config = function()
            require("window-picker").setup()
        end,
    },
}
ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = { "BufReadPost", "BufNewFile" },
    config = conf.gitsigns,
}
ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.indent_blankline,
}
ui["akinsho/bufferline.nvim"] = {
    opt = true,
    tag = "*",
    event = "BufReadPost",
    config = conf.nvim_bufferline,
}
ui["dstein64/nvim-scrollview"] = {
    opt = true,
    event = { "BufReadPost" },
    config = conf.scrollview,
}
ui["j-hui/fidget.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.fidget,
}

return ui

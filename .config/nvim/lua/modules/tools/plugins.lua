local tools = {}
local conf = require("modules.tools.config")

tools["nvim-lua/plenary.nvim"] = { opt = false }
tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    module = "telescope",
    cmd = "Telescope",
    config = conf.telescope,
    requires = {
        { "nvim-lua/plenary.nvim", opt = false },
        { "nvim-lua/popup.nvim", opt = true },
    },
    wants = { "plenary.nvim", "popup.nvim" },
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim",
}
tools["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
    after = "telescope-fzf-native.nvim",
    requires = { {
        "ahmedkhalf/project.nvim",
        opt = true,
        config = conf.project,
    } },
}
tools["nvim-telescope/telescope-live-grep-args.nvim"] = {
    opt = true,
    after = "telescope-fzf-native.nvim",
}
tools["folke/trouble.nvim"] = {
    opt = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = conf.trouble,
}
tools["dstein64/vim-startuptime"] = { opt = true, cmd = "StartupTime" }
tools["gelguy/wilder.nvim"] = {
    event = "CmdlineEnter",
    config = conf.wilder,
    requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
}
-- Please don't remove which-key.nvim otherwise you need to set timeoutlen=300 at `lua/core/options.lua`
tools["folke/which-key.nvim"] = {
    opt = false,
    config = conf.which_key,
}
tools["mrjones2014/legendary.nvim"] = {
    opt = true,
    cmd = "Legendary",
    config = conf.legendary,
    requires = {
        { "stevearc/dressing.nvim", opt = false, config = conf.dressing },
    },
}

tools["rhysd/git-messenger.vim"] = {
    opt = true,
    cmd = "GitMessenger",
    keys = { "n", "<Leader>gm" },
    config = conf.git_messenger,
}

return tools

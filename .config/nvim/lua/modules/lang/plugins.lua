local lang = {}
local conf = require("modules.lang.config")

lang["iamcco/markdown-preview.nvim"] = {
    opt = true,
    ft = "markdown",
    run = "cd app && yarn install",
}
return lang

local formatting = require("modules.completion.formatting")

vim.api.nvim_command([[packadd lsp_signature.nvim]])
vim.api.nvim_command([[packadd lspsaga.nvim]])
vim.api.nvim_command([[packadd cmp-nvim-lsp]])

local nvim_lsp = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

require("lspconfig.ui.windows").default_options.border = "single"

mason.setup({
    ui = {
        border = "rounded",
    },
})
mason_lsp.setup({
    ensure_installed = {
        "ansiblels",
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "efm",
        "html",
        "jsonls",
        "pylsp",
        "rust_analyzer",
        "sumneko_lua",
        "tsserver",
        "yamlls",
        "zls",
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function custom_attach(client, bufnr)
    require("lsp_signature").on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = { "double" },
    })
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = nvim_lsp.util.validate_bufnr(bufnr)
    local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
        clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
                return
            end
            vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
        end)
    else
        vim.notify(
            "Method textDocument/switchSourceHeader is not supported by any active server on this buffer",
            vim.log.levels.ERROR,
            { title = "LSP Error!" }
        )
    end
end

-- Override server settings here

for _, server in ipairs(mason_lsp.get_installed_servers()) do
    if server == "gopls" then
        nvim_lsp.gopls.setup({
            on_attach = custom_attach,
            flags = { debounce_text_changes = 500 },
            capabilities = capabilities,
            cmd = { "gopls", "-remote=auto" },
            settings = {
                gopls = {
                    usePlaceholders = true,
                    analyses = {
                        nilness = true,
                        shadow = true,
                        unusedparams = true,
                        unusewrites = true,
                    },
                },
            },
        })
    elseif server == "sumneko_lua" then
        nvim_lsp.sumneko_lua.setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim", "packer_plugins" } },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                    telemetry = { enable = false },
                    semantic = { enable = false },
                },
            },
        })
    elseif server == "clangd" then
        local copy_capabilities = capabilities
        copy_capabilities.offsetEncoding = { "utf-16" }
        nvim_lsp.clangd.setup({
            capabilities = copy_capabilities,
            single_file_support = true,
            on_attach = custom_attach,
            cmd = {
                "clangd",
                "--background-index",
                "--pch-storage=memory",
                -- You MUST set this arg ↓ to your clangd executable location (if not included)!
                "--query-driver=/usr/bin/clang++,/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
                "--clang-tidy",
                "--all-scopes-completion",
                "--completion-style=detailed",
                "--header-insertion-decorators",
                "--header-insertion=iwyu",
            },
            commands = {
                ClangdSwitchSourceHeader = {
                    function()
                        switch_source_header_splitcmd(0, "edit")
                    end,
                    description = "Open source/header in current buffer",
                },
                ClangdSwitchSourceHeaderVSplit = {
                    function()
                        switch_source_header_splitcmd(0, "vsplit")
                    end,
                    description = "Open source/header in a new vsplit",
                },
                ClangdSwitchSourceHeaderSplit = {
                    function()
                        switch_source_header_splitcmd(0, "split")
                    end,
                    description = "Open source/header in a new split",
                },
            },
        })
    elseif server == "jsonls" then
        nvim_lsp.jsonls.setup({
            flags = { debounce_text_changes = 500 },
            capabilities = capabilities,
            on_attach = custom_attach,
            settings = {
                json = {
                    -- Schemas https://www.schemastore.org
                    schemas = {
                        {
                            fileMatch = { "package.json" },
                            url = "https://json.schemastore.org/package.json",
                        },
                        {
                            fileMatch = { "tsconfig*.json" },
                            url = "https://json.schemastore.org/tsconfig.json",
                        },
                        {
                            fileMatch = {
                                ".prettierrc",
                                ".prettierrc.json",
                                "prettier.config.json",
                            },
                            url = "https://json.schemastore.org/prettierrc.json",
                        },
                        {
                            fileMatch = { ".eslintrc", ".eslintrc.json" },
                            url = "https://json.schemastore.org/eslintrc.json",
                        },
                        {
                            fileMatch = {
                                ".babelrc",
                                ".babelrc.json",
                                "babel.config.json",
                            },
                            url = "https://json.schemastore.org/babelrc.json",
                        },
                        {
                            fileMatch = { "lerna.json" },
                            url = "https://json.schemastore.org/lerna.json",
                        },
                        {
                            fileMatch = {
                                ".stylelintrc",
                                ".stylelintrc.json",
                                "stylelint.config.json",
                            },
                            url = "http://json.schemastore.org/stylelintrc.json",
                        },
                        {
                            fileMatch = { "/.github/workflows/*" },
                            url = "https://json.schemastore.org/github-workflow.json",
                        },
                    },
                },
            },
        })
    elseif server == "yamlls" then
        nvim_lsp.yamlls.setup({
            format = {
                enable = true,
            },
            settings = {
                yaml = {
                    schemas = {
                        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
                    },
                },
            }
        })
    elseif server ~= "efm" then
        nvim_lsp[server].setup({
            capabilities = capabilities,
            on_attach = custom_attach,
        })
    end
end

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin

nvim_lsp.html.setup({
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = { css = true, javascript = true },
    },
    settings = {},
    single_file_support = true,
    flags = { debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = custom_attach,
})

local efmls = require("efmls-configs")

-- Init `efm-langserver` here.

efmls.init({
    on_attach = custom_attach,
    capabilities = capabilities,
    init_options = { documentFormatting = true, codeAction = true },
})

-- Require `efmls-configs-nvim`'s config here

local vint = require("efmls-configs.linters.vint")
local eslint = require("efmls-configs.linters.eslint")
local flake8 = require("efmls-configs.linters.flake8")
local shellcheck = require("efmls-configs.linters.shellcheck")

local black = require("efmls-configs.formatters.black")
local prettier = require("efmls-configs.formatters.prettier")
local shfmt = require("efmls-configs.formatters.shfmt")
local goimports = require("efmls-configs.formatters.goimports")

-- Add your own config for formatter and linter here
local clangfmt = require("modules.completion.efm.formatters.clangfmt")
local yamlfmt = require("modules.completion.efm.formatters.yamlfmt")

-- Override default config here

flake8 = vim.tbl_extend("force", flake8, {
    prefix = "flake8: max-line-length=160, ignore F403 and F405",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintCommand = "flake8 --max-line-length 160 --extend-ignore F403,F405 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
})

-- Setup formatter and linter for efmls here

efmls.setup({
    c = { formatter = clangfmt },
    cpp = { formatter = clangfmt },
    css = { formatter = prettier },
    go = { formatter = goimports },
    html = { formatter = prettier },
    javascript = { formatter = prettier, linter = eslint },
    javascriptreact = { formatter = prettier, linter = eslint },
    python = { formatter = black },
    scss = { formatter = prettier },
    sh = { formatter = shfmt, linter = shellcheck },
    typescript = { formatter = prettier, linter = eslint },
    typescriptreact = { formatter = prettier, linter = eslint },
    vim = { formatter = vint },
    vue = { formatter = prettier },
    -- yaml = { formatter = yamlfmt },
    zsh = { formatter = shfmt, linter = shellcheck },
})

formatting.configure_format_on_save()
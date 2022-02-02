local vim = vim

local override_keymap_with_lspsaga = function(bufnr, opts)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local saga_path = vim.fn.stdpath('data') ..
                          '/site/pack/packer/start/lspsaga.nvim'
    if vim.fn.empty(vim.fn.glob(saga_path)) > 0 then return end

    -- saga settings {{{
    local saga = require 'lspsaga'
    local saga_opt = {
        error_sign = vim.g.e_sign,
        warn_sign = vim.g.w_sign,
        hint_sign = vim.g.h_sign,
        finder_action_keys = {
            scroll_down = '<C-j>',
            scroll_up = '<C-k>',
            open = 'e',
            vsplit = '\\',
            split = '-'
        }
    }
    saga.init_lsp_saga(saga_opt)
    -- }}}

    buf_set_keymap('n', 'gh',
                   [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], opts)
    buf_set_keymap('n', '<Leader>ca',
                   [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]],
                   opts)
    buf_set_keymap('v', '<Leader>ca',
                   [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]],
                   opts)
    buf_set_keymap('n', 'gk',
                   [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]],
                   opts)
    buf_set_keymap('n', 'gK',
                   [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
                   opts)
    buf_set_keymap('n', 'gt',
                   [[<cmd>lua require('lspsaga.rename').rename()<CR>]], opts)
    buf_set_keymap('n', 'gp',
                   [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]],
                   opts)
    buf_set_keymap('n', '<C-j>',
                   [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
                   opts)
    buf_set_keymap('n', '<C-k>',
                   [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
                   opts)
    buf_set_keymap('n', 'sd',
                   [[<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]],
                   opts)
    buf_set_keymap('n', '[d', [[<cmd>Lspsaga diagnostic_jump_prev<CR>]], opts)
    buf_set_keymap('n', ']d', [[<cmd>Lspsaga diagnostic_jump_next<CR>]], opts)
end

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- diagnostics
    local diag_config = {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {spacing = 4, prefix = ""},
        -- Use a function to dynamically turn signs off
        -- and on, using buffer local variables
        signs = true,
        -- Disable a feature
        update_in_insert = false,
        severity_sort = true
    }

    local signs = {
        Error = vim.g.e_sign,
        Warn = vim.g.w_sign,
        Hint = vim.g.h_sign,
        Info = vim.g.i_sign
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diag_config)

    -- hilight
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {test = icon, texthl = hl, numhl = ""})
    end

    -- keymap
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)

    override_keymap_with_lspsaga(bufnr, opts)
end
local lspconfig = require 'lspconfig'
local lsp_installer_servers = require 'nvim-lsp-installer.servers'
local installed_lsp_servers = vim.fn.stdpath('data') .. '/lsp_servers'
local lsputil = require 'lspconfig/util'

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol
                                                          .make_client_capabilities())

-- lua {{{
local ok, sumneko_lua = lsp_installer_servers.get_server("sumneko_lua")
if ok then if not sumneko_lua:is_installed() then sumneko_lua:install() end end
local sumneko_root_path = installed_lsp_servers ..
                              '/sumneko_lua/extension/server/bin'
local sumneko_binary = sumneko_root_path .. "/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lua_lsp_config = {
    cmd = {sumneko_binary},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}
-- }}}

-- go {{{
local go_lsp_config = {
    settings = {
        gopls = {
            analyses = {unusedparams = true},
            staticcheck = true,
            gofumpt = true
        }
    }
}
-- }}}

-- rust {{{
-- https://rust-analyzer.github.io/manual.html#nvim-lsp
local rust_lsp_config = {
    settings = {
        ["rust-analyzer"] = {
            assist = {importGranularity = "module", importPrefix = "by_self"},
            cargo = {loadOutDirsFromCheck = true},
            procMacro = {enable = true}
        }
    }
}
-- }}}

-- docker {{{
local ok, dockerls = lsp_installer_servers.get_server("dockerls")
if ok then if not dockerls:is_installed() then dockerls:install() end end
local dockerls_binary = installed_lsp_servers ..
                            '/dockerfile/node_modules/.bin/docker-langserver'
local docker_lsp_config = {cmd = {dockerls_binary, "--stdio"}}
-- }}}

-- yaml {{{
local ok, yamlls = lsp_installer_servers.get_server("yamlls")
if ok then if not yamlls:is_installed() then yamlls:install() end end
local yamlls_binary = installed_lsp_servers ..
                          '/yaml/node_modules/.bin/yaml-language-server'
local yaml_lsp_config = {
    cmd = {yamlls_binary, "--stdio"},
    settings = {
        yaml = {
            schemas = {
                ["kubernetes"] = {"*.k8s.yaml", "/*k8s/**/*.yaml"},
                ["http://json.schemastore.org/kustomization"] = "/kustomization.yaml",
                ["https://raw.githubusercontent.com/cappyzawa/concourse-pipeline-jsonschema/master/concourse_jsonschema.json"] = "/pipeline.yml"
            },
            trace = {server = "verbose"}
        }
    }
}
-- }}}

-- bash {{{
local ok, bashls = lsp_installer_servers.get_server("bashls")
if ok then if not bashls:is_installed() then bashls:install() end end
local bashls_binary = installed_lsp_servers ..
                          '/bash/node_modules/.bin/bash-language-server'
local bash_lsp_config = {
    cmd = {bashls_binary, "start"},
    filetypes = {"sh", "bash", "zsh"}
}
-- }}}

-- deno {{{
local deno_lsp_config = {
    root_dir = lsputil.root_pattern("deps.ts", "dev_deps.ts", "mod.ts")
}
-- }}}

-- ts {{{
local ok, tsserver = lsp_installer_servers.get_server("tsserver")
if ok then if not tsserver:is_installed() then tsserver:install() end end
local tsserver_binary = installed_lsp_servers ..
                            '/tsserver/node_modules/.bin/typescript-language-server'
local ts_lsp_config = {
    cmd = {tsserver_binary, "--stdio"},
    root_dir = lsputil.root_pattern("package.json", "package-lock.json",
                                    "yarh-lock.json")
}
-- }}}

-- zig {{{
local ok, zls = lsp_installer_servers.get_server("zls")
if ok then if not zls:is_installed() then zls:install() end end
local zls_binary = installed_lsp_servers .. '/zls/package/zls'
local zig_lsp_config = {cmd = {zls_binary}}
-- }}}

-- json {{{
local ok, jsonls = lsp_installer_servers.get_server("jsonls")
if ok then if not jsonls:is_installed() then jsonls:install() end end
local jsonls_binary = installed_lsp_servers ..
                          '/jsonls/node_modules/.bin/vscode-json-language-server'
local json_lsp_config = {cmd = {jsonls_binary, "--stdio"}}
-- }}}

-- python {{{
local ok, pylsp = lsp_installer_servers.get_server("pylsp")
if ok then if not pylsp:is_installed() then pylsp:install() end end
local pylsp_binary = installed_lsp_servers .. '/pylsp/venv/bin/pylsp'
local python_lsp_config = {cmd = {pylsp_binary}}
-- }}}

-- clang {{{
local ok, clangd = lsp_installer_servers.get_server("clangd")
if ok then if not clangd:is_installed() then clangd:install() end end
local clangd_binary = installed_lsp_servers .. '/clangd/clangd'
local clang_lsp_config = {cmd = {clangd_binary, "--background-index"}}
-- }}}

-- julia {{{
-- }}}

-- elm {{{
local custom_attach = function(client)
    on_attach(client)
    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end
end

lspconfig.elmls.setup({
    on_attach = custom_attach
    -- capabilities = capabilities,
})
vim.cmd([[ autocmd BufWritePre *.elm lua vim.lsp.buf.formatting() ]])
-- }}}

-- efm {{{
local ok, efmls = lsp_installer_servers.get_server("efmls")
if ok then if not efmls:is_installed() then efmls:install() end end
local efmls_binary = installed_lsp_servers .. '/efm/efm-langserver'
local efm_lsp_config = {
    cmd = {efmls_binary, '-logfile', '/tmp/efm.log', '-loglevel', '5'},
    filetypes = {"rego", "lua"},
    init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    }
}
-- }}}

local servers = {
    sumneko_lua = lua_lsp_config,
    vimls = {},
    terraformls = {},
    gopls = go_lsp_config,
    rust_analyzer = rust_lsp_config,
    nimls = {},
    dockerls = docker_lsp_config,
    yamlls = yaml_lsp_config,
    bashls = bash_lsp_config,
    jsonls = json_lsp_config,
    denols = deno_lsp_config,
    tsserver = ts_lsp_config,
    zls = zig_lsp_config,
    pylsp = python_lsp_config,
    clangd = clang_lsp_config,
    solargraph = {},
    julials = {},
    efm = efm_lsp_config
}

for ls, config in pairs(servers) do
    lspconfig[ls].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        before_init = config.before_init,
        cmd = config.cmd,
        init_options = config.init_options,
        filetypes = config.filetypes,
        root_dir = config.root_dir,
        settings = config.settings
    }
end

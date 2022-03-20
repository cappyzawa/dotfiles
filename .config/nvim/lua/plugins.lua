local M = {}
local vim = vim
local api = vim.api

M.nvim_cmp = function()
    local cmp = require 'cmp'
    local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = ""
    }
    cmp.setup {
        formatting = {
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format('%s %s',
                    kind_icons[vim_item.kind],
                    vim_item.kind) -- This concatonates the icons with the name of the item kind
                -- Source
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]"
                })[entry.source.name]
                return vim_item
            end
        },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
            end
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = {
            ['<C-y>'] = cmp.config.disable,
            ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(),
                { 'i', 'c' }),
            ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(),
                { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<CR>'] = cmp.mapping.confirm({ select = true })
        },
        sources = {
            { name = "nvim_lsp" }, {
                name = "buffer",
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            }, { name = "path" }, { name = "nvim_lua" }, { name = "emoji" },
            { name = "vsnip" }
        }
    }

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline('/', {
        sources = {
            {
                name = 'buffer',
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            }
        }
    })

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
    })
end

M.goimports = function(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction",
        params, timeout_ms)
    if not result or next(result) == nil then return end
    local client_id = next(result)
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            local client = vim.lsp.get_client_by_id(client_id)
            vim.lsp.util.apply_workspace_edit(action.edit,
                client.offset_encoding)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

M.lspconfig = function()
    require 'lsp'
    vim.api.nvim_create_augroup('lsp_formatter', { clear = true })

    local ext_patterns = {
        ['*.go'] = function()
            M.goimports(1000)
            vim.lsp.buf.formatting()
        end,
        ['*.tf'] = function()
            vim.lsp.buf.formatting()
        end,
        ['*.ts'] = function() vim.lsp.buf.formatting() end,
        ['*.rs'] = function() vim.lsp.buf.formatting() end,
        ['*.rego'] = function() vim.lsp.buf.formatting() end,
        ['*.yaml'] = function() vim.lsp.buf.formatting() end,
        ['*.lua'] = function() vim.lsp.buf.formatting() end,
        ['*.zig'] = function() vim.lsp.buf.formatting() end,
        ['*.json'] = function() vim.lsp.buf.formatting() end,
        ['*.elm'] = function() vim.lsp.buf.formatting() end
    }
    for ext, f in pairs(ext_patterns) do
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = ext,
            callback = f,
            group = 'lsp_formatter'
        })
    end
end

M.lspsaga = function()
    local keymap_opt = { noremap = true, silent = true }
    local set_keymap = vim.api.nvim_set_keymap
    set_keymap('n', '<Leader>ot', [[<cmd>Lspsaga open_floaterm<CR>]], keymap_opt)
    set_keymap('n', '<Leader>ct', [[<cmd>Lspsaga close_floaterm<CR>]],
        keymap_opt)
    set_keymap('n', '<Leader>ct', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
        keymap_opt)
end

M.tokyonight = function()
    vim.g.tokyonight_style = 'night'
    vim.cmd [[colorscheme tokyonight]]
end

M.lualine = function()
    local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed
            }
        end
    end

    local diff_symbols = { added = ' ', modified = ' ', removed = ' ' }
    local diag_symbols = {
        error = vim.g.e_sign .. ' ',
        warn = vim.g.w_sign .. ' ',
        info = vim.g.i_sign .. ' ',
        hint = vim.g.h_sign .. ' '
    }

    local config = require 'tokyonight.config'
    local colors = require 'tokyonight.colors'.setup(config)
    local evel_mode = function()
        local mode_color = {
            n = colors.blue,
            i = colors.green,
            v = colors.purple,
            [''] = colors.purple,
            V = colors.purple,
            c = colors.yellow,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.purple,
            Rv = colors.purple,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red
        }
        vim.api.nvim_command('hi! LualineMode guifg=' ..
            mode_color[vim.fn.mode()] .. ' guibg=' ..
            colors.bg)
        return ''
    end
    require 'lualine'.setup {
        options = {
            theme = 'tokyonight',
            section_separators = '',
            component_separators = '',
            globalstatus = true,
        },
        sections = {
            lualine_a = { { evel_mode, color = 'LualineMode' } },
            lualine_b = {
                { 'b:gitsigns_head', icon = '' },
                { 'diff', source = diff_source, symbols = diff_symbols },
                { 'diagnostics', symbols = diag_symbols }
            },
            lualine_c = {
                { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
                { 'filename' }, {
                    'lsp_progress',
                    colors = {
                        percentage = colors.yellow,
                        title = colors.fg,
                        message = colors.yellow,
                        spinner = colors.yellow,
                        lsp_client_name = colors.blue,
                        use = true
                    },
                    separators = {
                        component = ' ',
                        progress = ' | ',
                        percentage = { pre = '', post = '%% ' },
                        title = { pre = '', post = ': ' },
                        lsp_client_name = { pre = '[', post = ']' },
                        spinner = { pre = '', post = '' },
                        message = {
                            commenced = 'In Progress',
                            completed = 'Completed'
                        }
                    },
                    display_components = {
                        'lsp_client_name', 'spinner',
                        { 'title', 'percentage', 'message' }
                    },
                    timer = {
                        progress_enddelay = 500,
                        spinner = 1000,
                        lsp_client_name_enddelay = 1000
                    },
                    spinner_symbols = {
                        '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ',
                        '🌗 ', '🌘 '
                    }
                }
            },
            lualine_x = { 'encoding', 'fileformat' }
        }
    }
end

M.git_messenger = function()
    local opt = { noremap = true, silent = true }
    vim.g.git_messenger_include_diff = 'current'
    vim.g.git_messenger_always_into_popup = true
    vim.g.git_messenger_no_default_mappings = true
    api.nvim_set_keymap('n', '<Leader>gm', ':<C-u>GitMessenger<CR>', opt)
end

M.treesitter = function()
    local treesitter_configs = require 'nvim-treesitter.configs'
    local execute = vim.api.nvim_command

    treesitter_configs.setup {
        ensure_installed = "maintained",
        highlight = { enable = true, disable = {} }
    }

    -- hcl {{{
    execute('autocmd BufRead,BufNewFile *.hcl set filetype=hcl')
    -- }}}
end

M.telescope = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    local extensions = { "terraform", "ghq" }
    for _, v in pairs(extensions) do telescope.load_extension(v) end

    telescope.setup {
        defaults = {
            vimgrep_arguments = {
                'rg', '--color=never', '--no-heading', '--with-filename',
                '--line-number', '--column', '--hidden'
            },
            file_ignore_patterns = { 'node_modules', '.git' },
            mappings = {
                i = {
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-x>"] = false,
                    ["<c-s>"] = actions.select_horizontal,
                    ["<c-v>"] = actions.select_vertical
                },
                n = {
                    ["jj"] = actions.close,
                    ["<c-x>"] = false,
                    ["<c-s>"] = actions.select_horizontal,
                    ["<c-v>"] = actions.select_vertical,
                    ["<c-j>"] = actions.preview_scrolling_down,
                    ["<c-k>"] = actions.preview_scrolling_up
                }
            }
        }
    }

    local opts = { noremap = true, silent = true }

    local keymap_telescope_func = {
        ["<Leader>ff"] = "require'telescope.builtin'.find_files()",
        ["<Leader>rg"] = "require'telescope.builtin'.live_grep()",
        ["<Leader>ch"] = "require'telescope.builtin'.command_history{}",
        ["<Leader>bl"] = "require'telescope.builtin'.buffers{show_all_buffers = true}",
        ["<Leader>gst"] = "require'telescope.builtin'.git_status()",
        ["<Leader>p"] = "require'telescope.builtin'.registers()",
        ["gr"] = "require'telescope.builtin'.lsp_references()",
        ["gi"] = "require'telescope.builtin'.lsp_implementations()"
    }

    for k, v in pairs(keymap_telescope_func) do
        api.nvim_set_keymap('n', k, string.format("<cmd>lua %s<CR>", v), opts)
    end
end

M.searchx = function()
    local opts = { noremap = true, silent = true }

    api.nvim_set_keymap('n', [[?]],
        [[<Cmd>call searchx#start({ 'dir': 0 })<CR>]], opts)
    api.nvim_set_keymap('n', [[/]],
        [[<Cmd>call searchx#start({ 'dir': 1 })<CR>]], opts)
    api.nvim_set_keymap('x', [[?]],
        [[<Cmd>call searchx#start({ 'dir': 0 })<CR>]], opts)
    api.nvim_set_keymap('x', [[/]],
        [[<Cmd>call searchx#start({ 'dir': 1 })<CR>]], opts)
    api.nvim_set_keymap('c', [[;]], [[<Cmd>call searchx#select()<CR>]], opts)

    api.nvim_set_keymap('n', 'N', '<Cmd>call searchx#prev_dir()<CR>', opts)
    api.nvim_set_keymap('n', 'n', '<Cmd>call searchx#next_dir()<CR>', opts)
    api.nvim_set_keymap('x', 'N', '<Cmd>call searchx#prev_dir()<CR>', opts)
    api.nvim_set_keymap('x', 'n', '<Cmd>call searchx#next_dir()<CR>', opts)

    api.nvim_set_keymap('n', '<C-k>', '<Cmd>call searchx#prev()<CR>', opts)
    api.nvim_set_keymap('n', '<C-j>', '<Cmd>call searchx#next()<CR>', opts)
    api.nvim_set_keymap('c', '<C-k>', '<Cmd>call searchx#prev()<CR>', opts)
    api.nvim_set_keymap('c', '<C-j>', '<Cmd>call searchx#next()<CR>', opts)
    api.nvim_set_keymap('x', '<C-k>', '<Cmd>call searchx#prev()<CR>', opts)
    api.nvim_set_keymap('x', '<C-j>', '<Cmd>call searchx#next()<CR>', opts)

    api.nvim_set_keymap('n', '<C-l>', '<Cmd>call searchx#clear()<CR>', opts)

    vim.g.searchx = { auto_accept = true }
end

M.trouble = function()
    require 'trouble'.setup {
        signs = {
            error = vim.g.e_sign,
            warning = vim.g.w_sign,
            info = vim.g.i_sign,
            hint = vim.g.h_sign
        }
    }

    local opts = { noremap = true, silent = true }
    api.nvim_set_keymap('n', 'gR', '<Cmd>TroubleToggle<CR>', opts)
end

M.indent_blankline = function()
    require 'indent_blankline'.setup {
        show_current_context = true,
        show_current_context_start = true
    }
end

M.hop = function()
    require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
    vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
    vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
    vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
    vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
    vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
end

return M

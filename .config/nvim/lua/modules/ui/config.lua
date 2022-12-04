local config = {}

function config.notify()
    local notify = require("notify")
    local icons = {
        diagnostics = require("modules.ui.icons").get("diagnostics"),
        ui = require("modules.ui.icons").get("ui"),
    }

    notify.setup({
        ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
        stages = "slide",
        ---@usage Function called when a new window is opened, use for changing win settings/config
        on_open = nil,
        ---@usage Function called when a window is closed
        on_close = nil,
        ---@usage timeout for notifications in ms, default 5000
        timeout = 2000,
        -- Render function for notifications. See notify-render()
        render = "default",
        ---@usage highlight behind the window for stages that change opacity
        background_colour = "Normal",
        ---@usage minimum width for notification windows
        minimum_width = 50,
        ---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
        level = "TRACE",
        ---@usage Icons for the different levels
        icons = {
            ERROR = icons.diagnostics.Error,
            WARN = icons.diagnostics.Warning,
            INFO = icons.diagnostics.Information,
            DEBUG = icons.ui.Bug,
            TRACE = icons.ui.Pencil,
        },
    })

    vim.notify = notify
end

function config.lualine()
    local icons = {
        diagnostics = require("modules.ui.icons").get("diagnostics", true),
        misc = require("modules.ui.icons").get("misc", true),
    }

    local function escape_status()
        local ok, m = pcall(require, "better_escape")
        return ok and m.waiting and icons.misc.EscapeST or ""
    end

    local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end

    local mini_sections = {
        lualine_a = { "filetype" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }
    local outline = {
        sections = mini_sections,
        filetypes = { "lspsagaoutline" },
    }

    local function python_venv()
        local function env_cleanup(venv)
            if string.find(venv, "/") then
                local final_venv = venv
                for w in venv:gmatch("([^/]+)") do
                    final_venv = w
                end
                venv = final_venv
            end
            return venv
        end

        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
            if venv then
                return string.format("%s", env_cleanup(venv))
            end
            venv = os.getenv("VIRTUAL_ENV")
            if venv then
                return string.format("%s", env_cleanup(venv))
            end
        end
        return ""
    end

    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = "tokyonight",
            disabled_filetypes = {},
            component_separators = "|",
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch" }, { "diff", source = diff_source } },
            lualine_c = {},
            lualine_x = {
                { escape_status },
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warning,
                        info = icons.diagnostics.Information,
                    },
                },
            },
            lualine_y = {
                { "filetype", colored = true, icon_only = true },
                { python_venv },
                { "encoding" },
                {
                    "fileformat",
                    icons_enabled = true,
                    symbols = {
                        unix = "LF",
                        dos = "CRLF",
                        mac = "CR",
                    },
                },
            },
            lualine_z = { "progress", "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {
            "quickfix",
            "nvim-tree",
            "nvim-dap-ui",
            "toggleterm",
            "fugitive",
            outline,
        },
    })
end

function config.nvim_tree()
    local icons = {
        diagnostics = require("modules.ui.icons").get("diagnostics"),
        documents = require("modules.ui.icons").get("documents"),
        git = require("modules.ui.icons").get("git"),
        ui = require("modules.ui.icons").get("ui"),
    }

    require("nvim-tree").setup({
        create_in_closed_folder = false,
        respect_buf_cwd = false,
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        sync_root_with_cwd = true,
        view = {
            adaptive_size = false,
            centralize_selection = false,
            width = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            hide_root_folder = false,
            float = {
                enable = false,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
        renderer = {
            add_trailing = false,
            group_empty = true,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "none",
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
            symlink_destination = true,
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    item = "│ ",
                    none = "  ",
                },
            },
            root_folder_label = ":.:s?.*?/..?",
            icons = {
                webdev_colors = true,
                git_placement = "before",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true,
                },
                padding = " ",
                symlink_arrow = "  ",
                glyphs = {
                    default = icons.documents.Default, --
                    symlink = icons.documents.Symlink, --
                    bookmark = icons.ui.Bookmark,
                    git = {
                        unstaged = icons.git.Mod_alt,
                        staged = icons.git.Add, --
                        unmerged = icons.git.Unmerged,
                        renamed = icons.git.Rename, --
                        untracked = icons.git.Untracked, -- "ﲉ"
                        deleted = icons.git.Remove, --
                        ignored = icons.git.Ignore, --◌
                    },
                    folder = {
                        -- arrow_open = "",
                        -- arrow_closed = "",
                        arrow_open = "",
                        arrow_closed = "",
                        default = icons.ui.Folder,
                        open = icons.ui.FolderOpen,
                        empty = icons.ui.EmptyFolder,
                        empty_open = icons.ui.EmptyFolderOpen,
                        symlink = icons.ui.SymlinkFolder,
                        symlink_open = icons.ui.FolderOpen,
                    },
                },
            },
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_root = false,
            ignore_list = {},
        },
        ignore_ft_on_setup = {},
        filters = {
            dotfiles = false,
            custom = { ".DS_Store" },
            exclude = {},
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
            remove_file = {
                close_window = true,
            },
        },
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            debounce_delay = 50,
            icons = {
                hint = icons.diagnostics.Hint_alt,
                info = icons.diagnostics.Information_alt,
                warning = icons.diagnostics.Warning_alt,
                error = icons.diagnostics.Error_alt,
            },
        },
        filesystem_watchers = {
            enable = true,
            debounce_delay = 50,
        },
        git = {
            enable = true,
            ignore = true,
            show_on_dirs = true,
            timeout = 400,
        },
        trash = {
            cmd = "gio trash",
            require_confirm = true,
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                dev = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false,
            },
        },
    })
end

function config.nvim_bufferline()
    local icons = { ui = require("modules.ui.icons").get("ui") }

    local opts = {
        options = {
            number = nil,
            modified_icon = icons.ui.Modified,
            buffer_close_icon = icons.ui.Close,
            left_trunc_marker = icons.ui.Left,
            right_trunc_marker = icons.ui.Right,
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_buffer_close_icons = true,
            show_buffer_icons = true,
            show_tab_indicators = true,
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            separator_style = "thin",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1,
                },
                {
                    filetype = "undotree",
                    text = "Undo Tree",
                    text_align = "center",
                    highlight = "Directory",
                    separator = true,
                },
            },
            diagnostics_indicator = function(count)
                return "(" .. count .. ")"
            end,
        },
        -- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
        -- Note: If you use catppuccin then modify the colors below!
        highlights = {},
    }

    if vim.g.colors_name == "catppuccin" then
        local cp = require("catppuccin.palettes").get_palette() -- Get the palette.
        cp.none = "NONE" -- Special setting for complete transparent fg/bg.

        local catppuccin_hl_overwrite = {
            highlights = require("catppuccin.groups.integrations.bufferline").get({
                styles = { "italic", "bold" },
                custom = {
                    mocha = {
                        -- Hint
                        hint = { fg = cp.rosewater },
                        hint_visible = { fg = cp.rosewater },
                        hint_selected = { fg = cp.rosewater },
                        hint_diagnostic = { fg = cp.rosewater },
                        hint_diagnostic_visible = { fg = cp.rosewater },
                        hint_diagnostic_selected = { fg = cp.rosewater },
                    },
                },
            }),
        }

        opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)
    end

    require("bufferline").setup(opts)
end

function config.gitsigns()
    require("gitsigns").setup({
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "│",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "_",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "~",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
            ["n ]g"] = {
                expr = true,
                "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
            },
            ["n [g"] = {
                expr = true,
                "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
            },
            -- Text objects
            ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        },
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame = true,
        current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = { internal = true },
    })
end

function config.indent_blankline()
    require("indent_blankline").setup({
        char = "│",
        show_first_indent_level = true,
        filetype_exclude = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "json",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
        },
        buftype_exclude = { "terminal", "nofile" },
        show_trailing_blankline_indent = false,
        show_current_context = true,
        context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
            "type",
            "var",
            "import",
        },
        space_char_blankline = " ",
    })
end

function config.scrollview()
    require("scrollview").setup({})
end

function config.fidget()
    require("fidget").setup({
        window = { blend = 0 },
    })
end

function config.tokyonight()
    require("tokyonight").setup({
        style = "night",
    })
end

function config.noice()
    local noice = require("noice")
    noice.setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = false,
            }
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            }
        },
    })
end

return config

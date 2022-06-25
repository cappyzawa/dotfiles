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
    TypeParameter = "",
    Copilot = "",
  }
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
        if entry.source.name == "copilot" then
          vim_item.kind = string.format('%s %s', kind_icons["Copilot"], "Copilot")
        end
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
          copilot = "[Copilot]",
        })[entry.source.name]
        return vim_item
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
      },
      {
        name = "path",
        option = {
          trailling_slash = true
        }
      },
      { name = "nvim_lua" }, { name = "emoji" },
      { name = "nvim_lsp_signature_help" },
      { name = "copilot" },
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
    sources = cmp.config.sources(
      { {
        name = 'path',
        option = {
          trailling_slash = true
        }
      } },
      { { name = 'cmdline' } }
    )
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
      vim.lsp.buf.format { async = true }
    end,
    ['*.tf'] = function() vim.lsp.buf.format { async = true } end,
    ['*.rs'] = function() vim.lsp.buf.format { async = true } end,
    ['*.rego'] = function() vim.lsp.buf.format { async = true } end,
    -- ['*.yaml'] = function() vim.lsp.buf.format { async = true } end,
    ['*.lua'] = function() vim.lsp.buf.format { async = true } end,
    ['*.zig'] = function() vim.lsp.buf.format { async = true } end,
    ['*.json'] = function() vim.lsp.buf.format { async = true } end,
    ['*.elm'] = function() vim.lsp.buf.format { async = true } end
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
        { 'filename' }
      },
      lualine_x = { 'encoding', 'fileformat' }
    }
  }
end

M.git_messenger = function()
  vim.g.git_messenger_include_diff = 'current'
  vim.g.git_messenger_always_into_popup = true
  vim.g.git_messenger_no_default_mappings = true
end

M.treesitter = function()
  local treesitter_configs = require 'nvim-treesitter.configs'
  local execute = vim.api.nvim_command

  treesitter_configs.setup {
    ensure_installed = "all",
    highlight = { enable = true, disable = {} }
  }

  -- hcl {{{
  execute('autocmd BufRead,BufNewFile *.hcl set filetype=hcl')
  -- }}}
end

M.telescope = function()
  local telescope = require 'telescope'
  local actions = require 'telescope.actions'

  local extensions = { "terraform", "ghq", "gh" }
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
  vim.api.nvim_set_keymap('n', 'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    , {})
  vim.api.nvim_set_keymap('n', 'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    , {})
  vim.api.nvim_set_keymap('o', 'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
    , {})
  vim.api.nvim_set_keymap('o', 'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
    , {})
  vim.api.nvim_set_keymap('', 't',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    , {})
  vim.api.nvim_set_keymap('', 'T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    , {})
end

M.notify = function()
  vim.notify = require("notify")

  vim.notify.setup({
    -- Minimum level to show
    level = "info",

    -- Animation style (see below for details)
    stages = "fade_in_slide_out",

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = nil,

    -- Function called when a window is closed
    on_close = nil,

    -- Render function for notifications. See notify-render()
    render = "default",

    -- Default timeout for notifications
    timeout = 5000,

    -- Max number of columns for messages
    max_width = nil,
    -- Max number of lines for a message
    max_height = nil,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
    background_colour = "Normal",

    -- Minimum width for notification windows
    minimum_width = 50,

    -- Icons for the different levels
    icons = {
      ERROR = vim.g.e_sign,
      WARN = vim.g.w_sign,
      INFO = vim.g.i_sign,
      DEBUG = "",
      TRACE = "✎",
    },
  })

  -- Utility functions shared between progress reports for LSP and DAP

  local client_notifs = {}

  local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then
      client_notifs[client_id] = {}
    end

    if not client_notifs[client_id][token] then
      client_notifs[client_id][token] = {}
    end

    return client_notifs[client_id][token]
  end

  local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

  local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
      local new_spinner = (notif_data.spinner + 1) % #spinner_frames
      notif_data.spinner = new_spinner

      notif_data.notification = vim.notify(nil, nil, {
        hide_from_history = true,
        icon = spinner_frames[new_spinner],
        replace = notif_data.notification,
      })

      vim.defer_fn(function()
        update_spinner(client_id, token)
      end, 100)
    end
  end

  local function format_title(title, client_name)
    return client_name .. (#title > 0 and ": " .. title or "")
  end

  local function format_message(message, percentage)
    return (percentage and percentage .. "%\t" or "") .. (message or "")
  end

  -- LSP integration
  -- Make sure to also have the snippet with the common helper functions in your config!

  vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then
      return
    end

    local notif_data = get_notif_data(client_id, result.token)

    if val.kind == "begin" then
      local message = format_message(val.message, val.percentage)

      notif_data.notification = vim.notify(message, "info", {
        title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
        icon = spinner_frames[1],
        timeout = false,
        hide_from_history = false,
      })

      notif_data.spinner = 1
      update_spinner(client_id, result.token)
    elseif val.kind == "report" and notif_data then
      notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
        replace = notif_data.notification,
        hide_from_history = false,
      })
    elseif val.kind == "end" and notif_data then
      notif_data.notification = vim.notify(val.message and format_message(val.message) or "Complete", "info", {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
      })

      notif_data.spinner = nil
    end
  end

  vim.cmd [[ 
  highlight link NotifyERRORBorder DiagnosticError
  highlight link NotifyWARNBorder DiagnosticWarn
  highlight link NotifyINFOBorder DiagnosticInfo
  highlight link NotifyDEBUGBorder DiagnosticOther
  highlight link NotifyTRACEBorder DiagnosticOther
  highlight link NotifyERRORIcon DiagnosticSignError
  highlight link NotifyWARNIcon DiagnosticSignWarn
  highlight link NotifyINFOIcon DiagnosticSignInfo
  highlight link NotifyDEBUGIcon DiagnosticSignOther
  highlight link NotifyTRACEIcon DiagnosticSignOther
  highlight link NotifyERRORTitle DiagnosticError
  highlight link NotifyWARNTitle DiagnosticWarn
  highlight link NotifyINFOTitle DiagnosticInfo
  highlight link NotifyDEBUGTitle DiagnosticHint 
  highlight link NotifyTRACETitle  DiagnosticHint
  highlight link NotifyERRORBody Noraml
  highlight link NotifyWARNBody Normal
  highlight link NotifyINFOBody Normal
  highlight link NotifyDEBUGBody Normal
  highlight link NotifyTRACEBody Normal
  ]]
end

return M

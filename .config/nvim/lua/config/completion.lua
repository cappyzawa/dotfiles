local config = {}

local colors = require("tokyonight.colors").setup({ style = "night" })

function config.lspsaga()
  local icons = {
    diagnostics = require("config.icons").get("diagnostics", true),
    kind = require("config.icons").get("kind", true),
    type = require("config.icons").get("type", true),
    ui = require("config.icons").get("ui", true),
  }
  local function set_sidebar_icons()
    -- Set icons for sidebar.
    local diagnostic_icons = {
      Error = icons.diagnostics.Error_alt,
      Warn = icons.diagnostics.Warning_alt,
      Info = icons.diagnostics.Information_alt,
      Hint = icons.diagnostics.Hint_alt,
    }
    for type, icon in pairs(diagnostic_icons) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
  end

  set_sidebar_icons()

  require("lspsaga").setup({
    preview = {
      lines_above = 1,
      lines_below = 12,
    },
    scroll_preview = {
      scroll_down = "<C-j>",
      scroll_up = "<C-k>",
    },
    request_timeout = 3000,
    finder = {
      edit = { "o", "<CR>" },
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = { "q", "<ESC>" },
    },
    definition = {
      edit = "<C-c>o",
      vsplit = "<C-c>v",
      split = "<C-c>s",
      tabe = "<C-c>t",
      quit = "q",
      close = "<Esc>",
    },
    code_action = {
      num_shortcut = true,
      keys = {
        quit = "q",
        exec = "<CR>",
      },
    },
    lightbulb = {
      enable = false,
      sign = true,
      enable_in_insert = true,
      sign_priority = 20,
      virtual_text = true,
    },
    diagnostic = {
      twice_into = false,
      show_code_action = false,
      show_source = true,
      keys = {
        exec_action = "<CR>",
        quit = "q",
        go_action = "g",
      },
    },
    rename = {
      quit = "<C-c>",
      exec = "<CR>",
      mark = "x",
      confirm = "<CR>",
      whole_project = true,
      in_select = true,
    },
    outline = {
      win_position = "right",
      win_with = "_sagaoutline",
      win_width = 30,
      show_detail = true,
      auto_preview = false,
      auto_refresh = true,
      auto_close = true,
      keys = {
        jump = "<CR>",
        expand_collapse = "u",
        quit = "q",
      },
    },
    symbol_in_winbar = {
      in_custom = true,
      enable = false,
      separator = " " .. icons.ui.Separator,
      hide_keyword = true,
      show_file = false,
      color_mode = true,
    },
    ui = {
      theme = "round",
      border = "single", -- Can be single, double, rounded, solid, shadow.
      winblend = 0,
      expand = icons.ui.ArrowClosed,
      collapse = icons.ui.ArrowOpen,
      preview = icons.ui.Newspaper,
      code_action = icons.ui.CodeAction,
      diagnostic = icons.ui.Bug,
      incoming = icons.ui.Incoming,
      outgoing = icons.ui.Outgoing,
      kind = {
        -- Kind
        Class = { icons.kind.Class },
        Constant = { icons.kind.Constant },
        Constructor = { icons.kind.Constructor },
        Enum = { icons.kind.Enum, colors.yellow },
        EnumMember = { icons.kind.EnumMember },
        Event = { icons.kind.Event, colors.yellow },
        Field = { icons.kind.Field, colors.teal },
        File = { icons.kind.File },
        Function = { icons.kind.Function, colors.blue },
        Interface = { icons.kind.Interface, colors.yellow },
        Key = { icons.kind.Keyword, colors.red },
        Method = { icons.kind.Method, colors.blue },
        Module = { icons.kind.Module, colors.blue },
        Namespace = { icons.kind.Namespace, colors.blue },
        Number = { icons.kind.Number },
        Operator = { icons.kind.Operator },
        Package = { icons.kind.Package, colors.blue },
        Property = { icons.kind.Property, colors.teal },
        Struct = { icons.kind.Struct, colors.yellow },
        TypeParameter = { icons.kind.TypeParameter },
        Variable = { icons.kind.Variable },
        -- Type
        Array = { icons.type.Array },
        Boolean = { icons.type.Boolean },
        Null = { icons.type.Null, colors.yellow },
        Object = { icons.type.Object, colors.yellow },
        String = { icons.type.String, colors.green },
        -- ccls-specific icons.
        TypeAlias = { icons.kind.TypeAlias, colors.green },
        Parameter = { icons.kind.Parameter, colors.blue },
        StaticMethod = { icons.kind.StaticMethod },
        -- Microsoft-specific icons.
        Text = { icons.kind.Text, colors.green },
        Snippet = { icons.kind.Snippet },
        Folder = { icons.kind.Folder, colors.blue },
        Unit = { icons.kind.Unit, colors.green },
        Value = { icons.kind.Value },
      },
    },
  })
end

function config.cmp()
  local icons = {
    kind = require("config.icons").get("kind", false),
    type = require("config.icons").get("type", false),
    cmp = require("config.icons").get("cmp", false),
  }
  -- vim.api.nvim_command([[packadd cmp-tabnine]])
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local border = function(hl)
    return {
      { "╭", hl },
      { "─", hl },
      { "╮", hl },
      { "│", hl },
      { "╯", hl },
      { "─", hl },
      { "╰", hl },
      { "│", hl },
    }
  end

  local cmp_window = require("cmp.utils.window")

  cmp_window.info_ = cmp_window.info
  cmp_window.info = function(self)
    local info = self:info_()
    info.scrollable = false
    return info
  end

  local compare = require("cmp.config.compare")
  local lspkind = require("lspkind")
  local cmp = require("cmp")

  cmp.setup({
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        border = border("Normal"),
        max_width = 80,
        max_height = 20,
      },
      documentation = {
        border = border("CmpDocBorder"),
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,
        require("copilot_cmp.comparators").score,
        -- require("cmp_tabnine.compare"),
        compare.offset,
        compare.exact,
        compare.score,
        require("cmp-under-comparator").under,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          symbol_map = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp),
        })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"
        return kind
      end,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      {
        name = "path",
        option = {
          trailling_slash = true,
        },
      },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
      { name = "copilot" },
    },
  })
end

function config.copilot()
  vim.defer_fn(function()
    require("copilot").setup({
      cmp = {
        enabled = true,
        method = "getCompletionsCycling",
      },
      panel = {
        -- if true, it can interfere with completions in copilot-cmp
        enabled = false,
      },
      suggestion = {
        -- if true, it can interfere with completions in copilot-cmp
        enabled = false,
      },
      filetypes = {
        ["dap-repl"] = false,
        terraform = false,
      },
    })
  end, 100)
end

return config
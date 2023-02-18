local config = {}

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

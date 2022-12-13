local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
    -- Vim map
    ["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent(),
    ["n|<C-x>k"] = map_cr("bdelete"):with_noremap():with_silent(),
    ["n|<C-s>"] = map_cu("write"):with_noremap(),
    ["n|Y"] = map_cmd("y$"),
    ["n|D"] = map_cmd("d$"),
    ["n|<leader>h"] = map_cmd("^"),
    ["n|<leader>l"] = map_cmd("$"),
    ["n|<leader>wh"] = map_cmd("<C-w>h"):with_noremap(),
    ["n|J"] = map_cmd("10j"):with_noremap(),
    ["n|K"] = map_cmd("10k"):with_noremap(),
    ["n|sh"] = map_cmd("<C-w>h"):with_noremap(),
    ["n|sl"] = map_cmd("<C-w>l"):with_noremap(),
    ["n|sj"] = map_cmd("<C-w>j"):with_noremap(),
    ["n|sk"] = map_cmd("<C-w>k"):with_noremap(),
    ["n|<A-[>"] = map_cr("vertical resize -5"):with_silent(),
    ["n|<A-]>"] = map_cr("vertical resize +5"):with_silent(),
    ["n|<A-;>"] = map_cr("resize -2"):with_silent(),
    ["n|<A-'>"] = map_cr("resize +2"):with_silent(),
    ["n|<C-q>"] = map_cmd(":wq<CR>"),
    ["n|<A-q>"] = map_cmd(":Bwipeout<CR>"),
    ["n|<A-S-q>"] = map_cmd(":q!<CR>"),
    ["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"),
    -- Insert
    ["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap(),
    ["i|<C-b>"] = map_cmd("<Left>"):with_noremap(),
    ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap(),
    ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"),
    ["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"),
    -- command line
    ["c|<C-h>"] = map_cmd("<Left>"):with_noremap(),
    ["c|<C-l>"] = map_cmd("<Right>"):with_noremap(),
    ["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
    ["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
    ["c|<C-b>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
    ["c|w!!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),
    -- Visual
    ["v|<leader>h"] = map_cmd("^"),
    ["v|<leader>l"] = map_cmd("$"),
    ["v|J"] = map_cmd("10j"),
    ["v|K"] = map_cmd("10k"),
    ["v|<C-j>"] = map_cmd(":m '>+1<cr>gv=gv"),
    ["v|<C-k>"] = map_cmd(":m '<-2<cr>gv=gv"),
    ["v|<"] = map_cmd("<gv"),
    ["v|>"] = map_cmd(">gv"),
}

bind.nvim_load_mapping(def_map)

local u = require("utils")

local opts = {
    "termguicolors";
    "nocompatible",
    "hidden",
    "hls",
    "ignorecase",
    "incsearch",
    "lbr", "bri", sbr = "⏎",
    mouse = "a",
    "number", "relativenumber",
    "smartcase",
    ts = 4, sw = 4, sts = 0, "et",
    "title",
    textwidth = 100, colorcolumn = 0,
    "splitbelow", "splitright",
    wildignore = "node_modules,__sapper__,target,vendor",
    signcolumn = "yes",
    "nobackup", undodir = "~/.local/share/nvim/undodir", "undofile",
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevelstart = 99,
    "noshowmode",
    completeopt = "menu",
    updatetime = "1000",
}

-- This plugin thinks it's reasonable to overwrite <left>, <right>, and <C-c> in insert mode,
-- which is totally whack.
vim.g.omni_sql_no_default_maps = 1337

for key, val in pairs(opts) do
    if type(key) == "string" then
        vim.cmd("set "..key.."="..val)
    else
        vim.cmd("set "..val)
    end
end

vim.g.asmsyntax = "nasm"

vim.cmd("colorscheme gruvbox")
vim.api.nvim_set_hl(0, "Normal", { bg="#1d2021" })

u.au("settings", {
    {"TermOpen", "setlocal nonu nornu signcolumn=no"},
    {"TextYankPost", function() vim.highlight.on_yank({higroup = "IncSearch", timeout = 100}) end}
})

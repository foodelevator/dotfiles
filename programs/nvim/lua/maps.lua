local telescope_builtin = require("telescope.builtin")
local completion = require("completion")
local toggle_term = require("toggle-term")

local map = function(mode, lhs, rhs, opts)
    if not opts then opts = {} end
    if opts["noremap"] == nil then
        opts["noremap"] = true
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end
local function nmap(lhs, rhs, opts) map('n', lhs, rhs, opts) end
local function tmap(lhs, rhs, opts) map('t', lhs, rhs, opts) end
local function xmap(lhs, rhs, opts) map('x', lhs, rhs, opts) end
local function imap(lhs, rhs, opts) map('i', lhs, rhs, opts) end

nmap("<space>", "")
vim.g.mapleader = ' '

imap("<c-l>", completion.complete)

nmap("<c-h>", "<c-w>h")
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-l>", "<c-w>l")

tmap("<esc>", "<c-\\><c-n>")

nmap("<leader>q", ":bd<cr>")
nmap("gp", ":bp<cr>")
nmap("gn", ":bn<cr>")
nmap("<leader>s", ":set invhls<cr>")

xmap("<leader>a", "<Plug>(EasyAlign)")
nmap("<leader>a", "<Plug>(EasyAlign)")

nmap("<leader>f", telescope_builtin.find_files)
nmap("<leader>w", telescope_builtin.lsp_workspace_symbols)
nmap("<leader>/", telescope_builtin.live_grep)
nmap("<leader>tb", telescope_builtin.buffers)
nmap("<leader>tt", telescope_builtin.builtin)

nmap("<leader>g", toggle_term.toggle_lazygit)

nmap("<leader>d", function() require("duck").hatch("ඞ", 0.5) end)
nmap("<leader>c", function() require("duck").cook("ඞ") end)

function lsp_enabled(b)
    local opts = { buffer = b }

    nmap("gd",        telescope_builtin.lsp_definitions,      opts)
    nmap("gr",        telescope_builtin.lsp_references,       opts)
    nmap("gi",        telescope_builtin.lsp_implementations,  opts)
    nmap("gy",        telescope_builtin.lsp_type_definitions, opts)
    nmap("<leader>r", vim.lsp.buf.rename,                     opts)
    nmap("[d",        vim.diagnostic.goto_prev,               opts)
    nmap("]d",        vim.diagnostic.goto_next,               opts)
    nmap("<leader>e", vim.diagnostic.open_float,              opts)
    nmap("<leader>E", vim.diagnostic.setqflist,               opts)
    nmap("<leader>k", vim.lsp.buf.hover,                      opts)
    imap("<c-k>",     vim.lsp.buf.signature_help,             opts)
    nmap("<leader>.", vim.lsp.buf.code_action,                opts)
    nmap("<leader>i", vim.lsp.buf.format,                     opts)
end

require('sibling-swap').setup { keymaps = {
    ['<C-h>'] = 'swap_with_left',
    ['<C-l>'] = 'swap_with_right',
} }

return { lsp_enabled = lsp_enabled }

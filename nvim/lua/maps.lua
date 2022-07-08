local telescope_builtin = require("telescope.builtin")
local neogit = require("neogit")

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

nmap("<c-h>", "<c-w>h")
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-l>", "<c-w>l")

tmap("<esc>", "<c-\\><c-n>")

nmap("<leader>q", ":bd<cr>")
nmap("<leader>n", ":bn<cr>")
nmap("<leader>p", ":bp<cr>")
nmap("<leader>s", ":set invhls<cr>")

xmap("<leader>a", "<Plug>(EasyAlign)")
nmap("<leader>a", "<Plug>(EasyAlign)")

nmap("<leader>lf", telescope_builtin.find_files)
nmap("<leader>lg", telescope_builtin.live_grep)
nmap("<leader>lb", telescope_builtin.buffers)
nmap("<leader>lt", telescope_builtin.builtin)

nmap("<leader>g", neogit.open)

function lsp_enabled(b)
    local opts = { buffer = b }

    nmap("gd",        vim.lsp.buf.definition,           opts)
    nmap("gr",        telescope_builtin.lsp_references, opts)
    -- nmap("gr",     vim.lsp.buf.references,           opts)
    nmap("gi",        vim.lsp.buf.implementation,       opts)
    nmap("gy",        vim.lsp.buf.type_definition,      opts)
    nmap("<leader>r", vim.lsp.buf.rename,               opts)
    nmap("[g",        vim.diagnostic.goto_prev,         opts)
    nmap("]g",        vim.diagnostic.goto_next,         opts)
    nmap("<leader>e", vim.diagnostic.open_float,        opts)
    nmap("<leader>E", vim.diagnostic.setqflist,         opts)
    nmap("K",         vim.lsp.buf.hover,                opts)
    imap("<c-k>",     vim.lsp.buf.signature_help,       opts)
    nmap("<leader>.", vim.lsp.buf.code_action,          opts)
    nmap("<leader>f", vim.lsp.buf.formatting,           opts)
end

return { lsp_enabled = lsp_enabled }

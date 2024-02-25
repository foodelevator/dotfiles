-- Settings
local set = vim.o

set.et = true
set.sw = 4
set.sts = -1
set.ts = 4
set.nu = true
set.signcolumn = "yes"
set.updatetime = 1000
set.ignorecase = true
set.smartcase = true
set.backup = false
set.undodir = vim.fn.stdpath("data") .. "/undodir"
set.undofile = true
set.splitright = true
set.splitbelow = true
set.breakindent = true
set.termguicolors = true

vim.g.omni_sql_no_default_maps = 1337
vim.g.asmsyntax = "nasm"

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("TermNoNumbers", {}),
    command = "setlocal nonu nornu signcolumn=no"
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    callback = vim.highlight.on_yank,
})

vim.filetype.add({
    filename = {
        ["compose.yaml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
    },
    extension = {
        templ = "templ",
    }
})

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.bd)
vim.keymap.set("n", "gp", vim.cmd.bp)
vim.keymap.set("n", "gn", vim.cmd.bn)
vim.keymap.set("n", "<leader>s", function() set.hls = not set.hls end)
vim.keymap.set("t", "<c-l>", "<c-\\><c-n>")
vim.keymap.set("n", "<space>", "<nop>", { silent = true })

vim.api.nvim_create_user_command("Djul", function(opts)
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, opts.line1 - 1, opts.line2, false)
    for i, line in ipairs(lines) do
        line = string.gsub(line, "…", "...")
        line = string.gsub(line, "“", '"')
        line = string.gsub(line, "”", '"')
        line = string.gsub(line, "‘", "'")
        line = string.gsub(line, "’", "'")
        lines[i] = line
    end
    vim.api.nvim_buf_set_lines(buf, opts.line1 - 1, opts.line2, false, lines)
end, { range = "%" })

local function lsp_maps(buf)
    local telescope_builtin = require("telescope.builtin")
    local opts = { buffer = buf }

    vim.keymap.set("n", "gd",        telescope_builtin.lsp_definitions,      opts)
    vim.keymap.set("n", "gr",        telescope_builtin.lsp_references,       opts)
    vim.keymap.set("n", "gi",        telescope_builtin.lsp_implementations,  opts)
    vim.keymap.set("n", "gy",        telescope_builtin.lsp_type_definitions, opts)
    vim.keymap.set("n", "<leader>d", telescope_builtin.diagnostics,          opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename,                     opts)
    vim.keymap.set("n", "[d",        vim.diagnostic.goto_prev,               opts)
    vim.keymap.set("n", "]d",        vim.diagnostic.goto_next,               opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,              opts)
    vim.keymap.set("n", "<leader>E", vim.diagnostic.setqflist,               opts)
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover,                      opts)
    vim.keymap.set("i", "<c-k>",     vim.lsp.buf.signature_help,             opts)
    vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action,                opts)
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.format,                     opts)
end

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        lsp_maps(ev.buf)

        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_set_hl(0, "LspReferenceText",  { bg = "#3c3836" })
            vim.api.nvim_set_hl(0, "LspReferenceRead",  { bg = "#3c3836" })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3c3836" })

            local group = vim.api.nvim_create_augroup("CursorHoldHighlightReferences", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                group = group,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end
})

local function setup_lsp()
    local lsp = require "lspconfig"
    local capabilities = require "cmp_nvim_lsp".default_capabilities()
    lsp.gopls.setup {
        capabilities = capabilities,
        settings = { gopls = {
            usePlaceholders = true,
            semanticTokens = true,
        } },
    }
    lsp.rust_analyzer.setup {
        capabilities = capabilities,
        settings = { ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
        } },
    }
    lsp.hls.setup {
        capabilities = capabilities,
        settings = { haskell = {
            formattingProvider = "fourmolu",
        } },
    }
    lsp.lua_ls.setup {
        capabilities = capabilities,
        settings = { Lua = {
            diagnostics = { globals = {
                "vim",
            } },
            telemetry = {
                enable = false,
            },
        } }
    }
    lsp.templ.setup { capabilities = capabilities }
    lsp.emmet_ls.setup { capabilities = capabilities }
    lsp.tsserver.setup { capabilities = capabilities }
    lsp.dockerls.setup { capabilities = capabilities }

    lsp.docker_compose_language_service.setup { capabilities = capabilities }
end

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { "folke/lazy.nvim", tag = "stable" },
    {
        "morhetz/gruvbox",
        init = function()
            vim.g.gruvbox_contrast_dark = "hard"
            vim.cmd.colorscheme("gruvbox")
            vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = "#bd85bf" })
            vim.api.nvim_set_hl(0, "@lsp.type.parameter.dockerfile", {})
            vim.api.nvim_set_hl(0, "@lsp.typemod.variable.callable", { link = "@function" })
            vim.api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.go", { link = "@function.builtin.go" })
        end
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
        lazy = false,
        keys = { { "-", vim.cmd.Oil } },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "rust", "go", "c", "zig",
                    "lua", "python", "haskell",
                    "fish", "bash",
                    "typescript", "svelte", "javascript", "css", "astro", "tsx", "prisma",
                    "nix",
                    "markdown",
                    "terraform", "hcl",
                    "sql",
                    "templ",
                },
                indent = { enable = true },
                highlight = { enable = true },
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>f", function() require "telescope.builtin".find_files() end },
            { "<leader>/", function() require "telescope.builtin".live_grep() end },
            { "<leader>t", function() require "telescope.builtin".resume() end },
            { "<leader><space>", function() require "telescope.builtin".buffers() end },
        },
        build = ":TSUpdate",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = setup_lsp,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            cmp.setup {
                completion = { autocomplete = false },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = {
                    ["<c-l>"] = cmp.mapping.confirm({ select = true }),
                    ["<c-e>"] = cmp.mapping.abort(),
                    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-f>"] = cmp.mapping.scroll_docs(4),
                    ["<c-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end),
                    ["<c-p>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                },
            }
        end,
        -- NOTE: If this is lazy, the `mapping`s from above don't
        -- work when completing for the first time
        lazy = false,
        keys = {
            { mode = "i", "<c-l>", function() require "cmp".complete() end },
            { mode = {"s"}, "<c-p>", function() require "luasnip".jump(-1) end },
            { mode = {"s"}, "<c-n>", function() require "luasnip".jump(1) end },
        },
    },
    { "wsdjeg/vim-fetch" },
    {
        "ggandor/leap.nvim",
        keys = {
            { "s", function() require "leap".leap {} end },
            { "S", function() require "leap".leap { backward = true } end },
        },
    },
    { "numToStr/Comment.nvim", config = true },
    { "willothy/flatten.nvim", config = true, lazy = false },
    { "folke/todo-comments.nvim", config = true },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>g", vim.cmd.LazyGit },
        },
    },
})

-- TODO:
-- https://github.com/jamestthompson3/nvim-remote-containers
-- https://github.com/kylechui/nvim-surround

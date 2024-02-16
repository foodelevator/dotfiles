vim.g.mapleader = " "

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
        config = function() require("nvim-treesitter.configs").setup {
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
        } end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>f", function() require "telescope.builtin".find_files() end },
            { "<leader>/", function() require "telescope.builtin".live_grep() end },
            { "<leader>t", function() require "telescope.builtin".resume() end },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lsp = require("lspconfig")
            lsp.gopls.setup { settings = {
                gopls = { usePlaceholders = true }
            } }
            lsp.templ.setup {}
            lsp.emmet_ls.setup {}
            lsp.rust_analyzer.setup {
                settings = { ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                    check = { command = "clippy" },
                } },
            }
            lsp.tsserver.setup {}
            lsp.hls.setup {
                settings = { haskell = {
                    formattingProvider = "fourmolu",
                } },
            }
            lsp.lua_ls.setup {
                settings = { Lua = {
                    diagnostics = { globals = {
                        "vim",
                    } },
                    telemetry = {
                        enable = false,
                    },
                } }
            }
        end,
    },
})

-- Settings
vim.o.et = true
vim.o.sw = 4
vim.o.sts = -1
vim.o.ts = 4
vim.o.nu = true
vim.o.signcolumn = "yes"

-- Keymaps
vim.keymap.set("n", "<leader>q", vim.cmd.bd)

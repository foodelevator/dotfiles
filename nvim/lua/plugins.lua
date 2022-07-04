local paqpath = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(paqpath)) > 0 then
    vim.fn.system {
        "git",
        "clone",
        "--depth=1",
        "https://github.com/savq/paq-nvim.git",
        paqpath,
    }
    vim.cmd("packadd paq-nvim")
end

require "paq" {
    "savq/paq-nvim",

    "ap/vim-css-color",
    "bronson/vim-trailing-whitespace",
    -- "glacambre/firenvim",
    "junegunn/vim-easy-align",
    "kyazdani42/nvim-web-devicons",
    "morhetz/gruvbox",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope.nvim",
    {"nvim-treesitter/nvim-treesitter", run = function() vim.cmd("TSUpdate") end},
    "TimUntersberger/neogit",
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "wsdjeg/vim-fetch",

    -- "evanleck/vim-svelte",
    -- "JuliaEditorSupport/julia-vim",
    -- "ziglang/zig.vim",

    -- "airblade/vim-gitgutter",
    -- "itchyny/lightline.vim",
    -- "prabirshrestha/vim-lsp",
    -- "ctrlpvim/ctrlp.vim",
}

require "treesitter"
require "lsp"
require "tele"
require "ngit"

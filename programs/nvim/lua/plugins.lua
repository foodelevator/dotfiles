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

-- https://github.com/rockerBOO/awesome-neovim#comment

require "paq" {
    "savq/paq-nvim",

    "airblade/vim-gitgutter",
    "akinsho/bufferline.nvim",
    "akinsho/toggleterm.nvim",
    "ap/vim-css-color",
    "bronson/vim-trailing-whitespace",
    "ggandor/leap.nvim",
    "github/copilot.vim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/nvim-cmp",
    "hrsh7th/vim-vsnip",
    "junegunn/vim-easy-align",
    "kaarmu/typst.vim",
    "kyazdani42/nvim-web-devicons",
    "morhetz/gruvbox",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    {"nvim-treesitter/nvim-treesitter", run = function() vim.cmd("TSUpdate") end},
    "tamton-aquib/duck.nvim",
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "Wansmer/sibling-swap.nvim",
    "wsdjeg/vim-fetch",

    -- "glacambre/firenvim",
    -- "evanleck/vim-svelte",
    -- "JuliaEditorSupport/julia-vim",
    -- "ziglang/zig.vim",
}

require "bline"
require "completion"
require "lsp"
require "snippets"
require "tele"
require "toggle-term"
require "treesitter"

require('leap').add_default_mappings()

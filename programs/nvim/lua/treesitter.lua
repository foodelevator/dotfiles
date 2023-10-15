local configs = require "nvim-treesitter.parsers".get_parser_configs()
configs.templ = {
    install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = {"src/parser.c", "src/scanner.c"},
        branch = "master",
    },
}
vim.treesitter.language.register("templ", "templ")

require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "rust",
        "go",
        "c",
        "lua",
        "typescript",
        "nix",
        "svelte", "javascript", "css",
        "astro", "tsx",
        "markdown",
        "haskell",
        "zig",
        "prisma",
        "fish", "bash",
        "python",
        "terraform", "hcl",
        "sql",
        "templ",
    },
    sync_install = false,

    indent = { enable = true },

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

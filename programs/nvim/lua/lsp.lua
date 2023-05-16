local maps = require("maps")
local u = require("utils")
local completion = require("completion")

function on_attach(client, b)
    vim.api.nvim_buf_set_option(b, "omnifunc", "v:lua.vim.lsp.omnifunc")
    maps.lsp_enabled(b)

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
            hi! LspReferenceRead  guibg=#3c3836
            hi! LspReferenceText  guibg=#3c3836
            hi! LspReferenceWrite guibg=#3c3836
        ]]

        u.au("lsp_document_hightlight", {
            {"CursorHold", vim.lsp.buf.document_highlight},
            {"CursorMoved", vim.lsp.buf.clear_references},
        }, b)
    end
end

local lspconfig = require("lspconfig")

function server(name, cmd, settings)
    arg = { on_attach = on_attach, capabilities = completion.capabilities }
    if cmd ~= nil then
        arg.cmd = cmd
    end
    if settings ~= nil then
        arg.settings = settings
    end
    lspconfig[name].setup(arg)
end

server("rust_analyzer", { "rustup", "run", "nightly", "rust-analyzer" }, {
    ["rust-analyzer"] = {
        cargo = {
            allFeatures = true,
        },
        check = { command = "clippy" },
        diagnostics = {
            disabled = { "inactive-code" },
        },
    },
})
server("gopls", nil, {
    gopls = {
        usePlaceholders = true,
        analyses = { unusedparams = true },
    },
})
server("rnix")
server("java_language_server", { "java-language-server" })
server("astro") -- npm i -g @astrojs/language-server
server("tailwindcss") -- npm i -g @tailwindcss/language-server
server("tsserver") -- npm i -g typescript typescript-language-server
server("hls", nil, { haskell = { formattingProvider = "fourmolu" } })
server("prismals")
server("emmet_ls") -- npm i -g emmet-ls
server("typst_lsp")

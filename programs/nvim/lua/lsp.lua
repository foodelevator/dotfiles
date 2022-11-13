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

function server(name, cmd)
    arg = { on_attach = on_attach, capabilities = completion.capabilities }
    if cmd ~= nil then
        arg.cmd = cmd
    end
    lspconfig[name].setup(arg)
end

server("rust_analyzer", { "rustup", "run", "nightly", "rust-analyzer" })
server("gopls")
server("rnix")
server("java_language_server", { "java-language-server" })

-- lspconfig.rust_analyzer.setup        { on_attach = on_attach, capabilities = completion.capabilities }
-- lspconfig.gopls.setup                { on_attach = on_attach, capabilities = completion.capabilities }
-- lspconfig.dartls.setup               { on_attach = on_attach, capabilities = completion.capabilities }
-- lspconfig.rnix.setup                 { on_attach = on_attach, capabilities = completion.capabilities }
-- lspconfig.java_language_server.setup {
--     on_attach = on_attach,
--     capabilities = completion.capabilities,
--     cmd = { "java-language-server" },
-- }

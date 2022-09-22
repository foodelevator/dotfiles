local maps = require("maps")
local u = require("utils")
local completion = require("completion")

function on_attach(client, b)
    vim.api.nvim_buf_set_option(b, "omnifunc", "v:lua.vim.lsp.omnifunc")
    maps.lsp_enabled(b)

    if client.resolved_capabilities.document_highlight then
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

lspconfig.rust_analyzer.setup        { on_attach = on_attach, capabilities = completion.capabilities }
lspconfig.gopls.setup                { on_attach = on_attach, capabilities = completion.capabilities }
lspconfig.dartls.setup               { on_attach = on_attach, capabilities = completion.capabilities }
lspconfig.rnix.setup                 { on_attach = on_attach, capabilities = completion.capabilities }
lspconfig.java_language_server.setup {
    on_attach = on_attach,
    cmd = { "java-language-server" },
    capabilities = completion.capabilities,
}

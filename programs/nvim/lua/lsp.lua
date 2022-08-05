local maps = require("maps")
local u = require("utils")

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

lspconfig.rust_analyzer.setup    { on_attach = on_attach }
lspconfig.gopls.setup            { on_attach = on_attach }

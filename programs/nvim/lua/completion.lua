local cmp = require "cmp"

local M = {}

cmp.setup {
    completion = { autocomplete = false },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-l>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ })
            else
                fallback()
            end
        end,
        ['<C-p>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ })
            else
                fallback()
            end
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }),
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
}

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

M.complete = cmp.complete

return M

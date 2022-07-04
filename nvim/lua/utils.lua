local M = {}

function M.au(name, cmds, b)
    vim.api.nvim_create_augroup(name, {
        clear = b == nil
    })

    vim.api.nvim_clear_autocmds {
        buffer = b,
        group = name,
    }
    for _, cmd in ipairs(cmds) do
        s = {
            group = name,
            buffer = b,
        }
        if type(cmd[2]) == "string" then
            s.command = cmd[2]
        else
            s.callback = cmd[2]
        end
        vim.api.nvim_create_autocmd(cmd[1], s)
    end
end

return M

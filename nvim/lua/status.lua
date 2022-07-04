vim.api.nvim_exec(
[[
    hi StatusNormalMode guifg=#f2e5bc guibg=#427b58
    hi StatusInsertMode guifg=#f2e5bc guibg=#076678
    hi StatusVisualMode guifg=#f2e5bc guibg=#af3a03
    hi StatusOtherMode guifg=#f2e5bc guibg=#fb4934
    hi StatusReplaceMode guifg=#f2e5bc guibg=#8f3f71
    hi StatusCommandMode guifg=#1d2021 guibg=#8ec07c

    hi StatusFile guifg=#f9f5d7 guibg=#665c54
    hi StatusPercent guifg=#d5c4a1 guibg=#504945
    hi StatusBranch guifg=#f9f5d7  guibg=#7c6f64
]], false)

local modes = {
    n      = "%#StatusNormalMode# normal ",
    no     = "%#StatusNormalMode# normal ",

    v      = "%#StatusVisualMode# visual ",
    V      = "%#StatusVisualMode# v·line ",
    [""] = "%#StatusVisualMode# v·block ",

    i      = "%#StatusInsertMode# insert ",

    R      = "%#StatusReplaceMode# replace ",
    Rv     = "%#StatusReplaceMode# v·replace ",

    c      = "%#StatusCommandMode# command ",
    cv     = "%#StatusCommandMode# vim·ex ",
    ce     = "%#StatusCommandMode# ex ",

    s      = "%#StatusOtherMode# select ",
    S      = "%#StatusOtherMode# s·line ",
    [""] = "%#StatusOtherMode# s·block ",
    r      = "%#StatusOtherMode# prompt ",
    rm     = "%#StatusOtherMode# more ",
    ["r?"] = "%#StatusOtherMode# confirm ",
    ["!"]  = "%#StatusOtherMode# shell ",

    t      = "%#StatusInsertMode# terminal ",
    nt     = "%#StatusNormalMode# terminal ",
}

function get_status_line()
    local mode = vim.api.nvim_get_mode().mode
    local branch = vim.fn["FugitiveHead"]()
    if branch ~= "" then branch = branch .. " " end

    return table.concat {
        modes[mode] or mode,
        "%#StatusFile# %f:%l:%c ",
        "%* ", branch, "%m%r%q",
        "%*%=",
        "%* 0x%B ",
        "%*%#StatusFile# %{&filetype} ",
        "%#StatusPercent# %p%% ",
    }
end

vim.o.statusline = "%{%v:lua.get_status_line()%}"

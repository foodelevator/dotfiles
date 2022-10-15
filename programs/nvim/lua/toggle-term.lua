local Terminal = require("toggleterm.terminal").Terminal
local toggleterm = require "toggleterm"

local M = {}

toggleterm.setup {}

function M.toggle()
    toggleterm.toggle(0)
end

local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
})
function M.toggle_lazygit()
    lazygit:toggle()
end

return M

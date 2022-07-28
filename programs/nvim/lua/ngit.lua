local neogit = require("neogit")

neogit.setup {
    kind = "split",
    mappings = {
        status = {
            ["<tab>"] = "",
            ["="] = "Toggle",
        }
    }
}

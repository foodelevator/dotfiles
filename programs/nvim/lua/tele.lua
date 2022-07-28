local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

telescope.setup {
    defaults = {
        mappings = {
            n = {
                ["<c-p>"] = telescope_actions.move_selection_previous,
                ["<c-n>"] = telescope_actions.move_selection_next,
            },
        },
        file_ignore_patterns = {
            "vendor"
        },
    },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    dd = telescope_actions.delete_buffer,
                },
            },
        },
    },
}

telescope.load_extension("fzy_native")

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "master",
    config = function()
        -- local configs = require("nvim-treesitter.config")

        -- configs.setup({
        --     ensure_installed = { "c", "lua", "rust", "zig" },
        --     sync_install = false,
        --     highlight = { enable = true },
        --     indent = { enable = true },
        -- })
    end,
}

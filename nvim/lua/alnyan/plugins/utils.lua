return {
    -- File finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup {

            }

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "", builtin.find_files)
            vim.keymap.set("n", "", builtin.oldfiles)
            vim.keymap.set("n", "<leader>ff", builtin.live_grep)
        end
    },
    -- Git gutter bar
    {
        "airblade/vim-gitgutter"
    }
}

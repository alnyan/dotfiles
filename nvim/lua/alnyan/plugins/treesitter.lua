return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    main = 'nvim-treesitter.config',
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ctx)
                local hasStarted = pcall(vim.treesitter.start)
            end,
        })
    end,
}

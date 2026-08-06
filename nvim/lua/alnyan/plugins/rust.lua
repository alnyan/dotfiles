return {
    {
        "mrcjkb/rustaceanvim",
        lazy = false,
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    root_dir = function(fname, default)
                        if not fname or fname == "" then
                            return default(fname)
                        end
                        local root = vim.fs.root(fname, { "rust-toolchain.toml", "Cargo.toml" })
                        return root or default(fname)
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            procMacro = {
                                enable = true,
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                        },
                    },
                },
            }
        end
    }
}

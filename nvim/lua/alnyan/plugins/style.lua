return {
	{
		"crusoexia/vim-monokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme monokai]])
		end
	},
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup {
                sections = {
                    lualine_c = {
                        {
                            "buffers",
                            show_filename_only = false
                        }
                    }
                }
            }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            local hooks = require("ibl.hooks")
            local highlight = {
                "IndentOdd",
                "IndentEven"
            }
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "IndentOdd", { bg = "#242424" })
                vim.api.nvim_set_hl(0, "IndentEven", { ctermbg = "black" })
            end)
            require("ibl").setup {
                indent = {
                    highlight = highlight,
                    char = "",
                },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false
                },
                scope = { enabled = false }
            }
        end
    }
}

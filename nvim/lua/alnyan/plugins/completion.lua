return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    },
                    ["<S-Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                    ["<Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                },
                sources = {
                    { name = "nvim_lsp" }
                }
            }

            vim.cmd([[
                set completeopt=menuone,noinsert,noselect
            ]])
        end,
    },
    {
        "ziglang/zig.vim",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            vim.g.zig_fmt_parse_errors = 0
            vim.g.zig_fmt_autosave = 1
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "InsertEnter",
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.zls.setup {
                settings = {
                    zls = {
                        semantic_tokens = "partial",
                    }
                }
            }
        end,
    }
}

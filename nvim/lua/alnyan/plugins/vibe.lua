return {
    {
        "avante-corp/avante.nvim",
        build = "make",
        event = "VeryLazy",
        version = false,
        opts = {
            provider = "llama_cpp",
            providers = {
                llama_cpp = {
                    __inherited_from = 'openai',
                    endpoint = "http://127.0.0.1:8080/v1",
                    model = "none",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 4096
                    }
                }
            },
            mode = "agentic",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
        }
    }
}

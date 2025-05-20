local ts_parsers = require'nvim-treesitter.parsers'
local ts_configs = require'nvim-treesitter.configs'
local nvim_lsp = require'lspconfig'
local rust_tools = require'rust-tools'
local luasnip = require'luasnip'
local nlspsettings = require'nlspsettings'

ts_configs.setup {
    highlights = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

nlspsettings.setup {
    config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
    local_settings_dir = '.nlsp-settings',
    local_settings_root_markers_fallback = { '.git' },
    append_default_schemas = true,
    loader = 'json'
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        if err ~= nil and err.code == -32603 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

rust_tools.setup {
    capabilities = capabilities,
    on_init = function(client)
        client.offset_encoding = "utf-8"
    end
}

nvim_lsp.hls.setup {
    capabilities = capabilities
}

nvim_lsp.zls.setup {
    capabilities = capabilities
}

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

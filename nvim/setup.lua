local ts_parsers = require'nvim-treesitter.parsers'
local ts_configs = require'nvim-treesitter.configs'
local nvim_lsp = require'lspconfig'
local rust_tools = require'rust-tools'
local luasnip = require'luasnip'
local orgmode = require'orgmode'

local parser_config = ts_parsers.get_parser_configs()
parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
        files = {'src/parser.c', 'src/scanner.cc'},
    },
    filetype = 'org',
}
ts_configs.setup {
    highlights = {
        enable = true,
        disable = {'org'},
        additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

rust_tools.setup {
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
    { name = 'orgmode' },
  },
}

orgmode.setup {
    org_agenda_files = {'~/Documents/org/*'},
    org_default_notes_file = '~/Documents/org/main.org'
}

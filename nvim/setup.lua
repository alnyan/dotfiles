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

rust_tools.setup {
    capabilities = capabilities
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

function rs_create_module(name, as_directory)
    local parent_module_dir = vim.api.nvim_buf_get_name(0)
    parent_module_dir = vim.fs.dirname(parent_module_dir)

    -- Find a location to insert the module reference
    vim.fn.execute(":1")
    local n = vim.fn.search("\\(pub\\)\\? use ")
    local mod_text = "pub mod " .. name .. ";"
    local location

    if n == 0 then
        location = vim.fn.line("^")
    else
        location = vim.fn.line(".")
    end

    vim.fn.append(location, mod_text)
    vim.cmd("w")

    if as_directory then
        vim.cmd("!mkdir -p " .. parent_module_dir .. "/" .. name)
        vim.cmd("edit " .. parent_module_dir .. "/" .. name .. "/mod.rs")
    else
        vim.cmd("edit " .. parent_module_dir .. "/" .. name .. ".rs")
    end
end

-- Mark's custom bindings
vim.keymap.set('n', 'gm', function()
    if vim.bo.filetype ~= "rust" then
        return
    end

    local name = vim.fn.input("Module name: ")
    -- TODO check if it's a legal or nested module name?

    if name == "" then
        return
    end

    rs_create_module(name, false)
end)

vim.keymap.set('n', 'gM', function()
    if vim.bo.filetype ~= "rust" then
        return
    end

    local name = vim.fn.input("Module name: ")
    -- TODO check if it's a legal or nested module name?

    if name == "" then
        return
    end

    rs_create_module(name, true)
end)

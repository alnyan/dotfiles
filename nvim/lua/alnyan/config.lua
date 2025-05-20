local g = vim.g
local o = vim.opt

vim.cmd([[
    filetype plugin indent on
]])

-- Global
g.mapleader = "\\"
g.maplocalleader = "\\"

-- Opt
o.syntax = "on"
o.number = true
-- o.t_Co = 256
o.relativenumber = true
o.numberwidth = 5
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.colorcolumn = "100"
o.cursorline = true

o.eol = false
o.fixeol = false
o.fixendofline = false
o.endofline = false

o.ignorecase = true
o.smartcase = true

o.foldlevelstart = 99

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "R", vim.lsp.buf.rename)
vim.keymap.set("n", "D", vim.lsp.buf.definition)
vim.keymap.set("n", "U", vim.lsp.buf.incoming_calls)
vim.keymap.set("n", "<C-/>", function()
    vim.cmd([[nohlsearch]])
end)

function ay_pipe_buffer(command)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local input = table.concat(lines, "\n")

    local result = vim.system(command, { stdin = input }):wait()

    if result.code == 0 then
        local save_cursor = vim.fn.getpos(".")
        local output_lines = vim.split(result.stdout, '\n', { plain = true })
        if #output_lines > 0 and output_lines[#output_lines] == "" then
            table.remove(output_lines, #output_lines)
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, false, output_lines)
        vim.fn.setpos(".", save_cursor)
    end
end

function ay_format_rust()
    ay_pipe_buffer({ "rustfmt", "--edition=2021" })
end

function ay_format_zig()
    ay_pipe_buffer({ "zig", "fmt", "--stdin" })
end

vim.keymap.set("n", "gf", ay_format_rust)

-- Trim trailing whitespace on file write
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(ev)
        local save_cursor = vim.fn.getpos(".") -- Save cursor position
        vim.cmd([[%s/\s\+$//e]])                -- Remove trailing whitespace
        vim.fn.setpos(".", save_cursor)        -- Restore cursor position
    end
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = ay_format_rust
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.zig",
    callback = ay_format_zig
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

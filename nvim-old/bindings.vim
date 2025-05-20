fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! AutoFmt()
    if &syntax == "rust"
        execute "%!rustfmt --edition 2021"
    elseif &syntax == "cpp" || &syntax == "c"
        execute "%!clang-format"
    elseif &syntax == "zig"
        execute "%!zig fmt --stdin"
    endif
endfun

lua <<EOF
function alnyan_switch_case(sw)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local word = vim.fn.expand("<cword>")
    if sw == 'cs' then
        local i = 1
        local indices = {}
        while true do
            local m = string.find(word, "%u", i)
            if m == nil then
                break
            end

            i = m + 1
            indices[m] = true
        end
        if table.maxn(indices) ~= 0 and indices[1] then
            local rword = ""
            local j = 1
            while j <= string.len(word) do
                local c = string.sub(word, j, j)
                if indices[j] then
                    if j ~= 1 then
                        rword = rword .. "_"
                    end
                    rword = rword .. string.lower(c)
                else
                    rword = rword .. c
                end
                j = j + 1
            end

            local start_col, end_col = nil, nil
            for s, e in line:gmatch("()%S+()") do
                if s - 1 <= col and col < e - 1 then
                    start_col, end_col = s - 1, e - 1
                    break
                end
            end

            if start_col and end_col then
                local new_line = line:sub(1, start_col) .. rword .. line:sub(end_col + 1)
                vim.api.nvim_set_current_line(new_line)
            end
        end
    end
    -- print(line, col, word)
end
EOF

autocmd! BufNewFile,BufRead *.vert,*.frag set ft=glsl
autocmd BufWritePre * :call TrimWhitespace()

" C-/: clear current search highlight
noremap <silent> <C-/> :nohlsearch<Enter>

" LSP
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> R <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> D <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> U <cmd>lua vim.lsp.buf.incoming_calls()<cr>

" VimTex
nnoremap <silent> <leader>lc <cmd>VimtexCompile<cr>
nnoremap <silent> <leader>ll <cmd>VimtexReload<cr>
nnoremap <silent> <leader>lv <cmd>VimtexView<cr>

" FZF
nnoremap <silent>  <cmd>Files<cr>
nnoremap <silent>  <cmd>History<cr>
nnoremap <silent> <leader>ff <cmd>Rg<cr>

" orgmode
nnoremap <silent> <leader>tt <cmd>edit ~/Documents/org/main.org<cr>

" Custom functions
noremap gf :call AutoFmt()<Enter>
noremap gcs :lua alnyan_switch_case('cs')<ENTER>

let g:vimspector_enable_mappings = 'HUMAN'

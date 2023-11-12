fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! AutoFmt()
    if &syntax == "rust"
        execute "%!rustfmt --edition 2018"
    elseif &syntax == "cpp" || &syntax == "c"
        execute "%!clang-format-14"
    endif
endfun

autocmd! BufNewFile,BufRead *.vert,*.frag set ft=glsl
autocmd BufWritePre * :call TrimWhitespace()

" C-/: clear current search highlight
noremap <silent>  :nohlsearch<Enter>

" LSP
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> R <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> D <cmd>lua vim.lsp.buf.definition()<cr>

" FZF
nnoremap <silent>  <cmd>Files<cr>
nnoremap <silent>  <cmd>History<cr>
nnoremap <silent> <leader>ff <cmd>Rg<cr>

" orgmode
nnoremap <silent> <leader>tt <cmd>edit ~/Documents/org/main.org<cr>

" Custom functions
noremap gf :call AutoFmt()<Enter>

let g:vimspector_enable_mappings = 'HUMAN'

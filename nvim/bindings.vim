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

fun! GitCheckoutBranchSelect(item)
    execute 'Git checkout ' .. a:item
endfun

autocmd! BufNewFile,BufRead *.vert,*.frag set ft=glsl
autocmd BufWritePre * :call TrimWhitespace()

command! GitCheckoutBranch call fzf#run({'source': 'git branch --no-color', 'sink': function('GitCheckoutBranchSelect')})

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

" Git stuff
noremap <silent> gC <cmd>GitCheckoutBranch<Enter>

let g:vimspector_enable_mappings = 'HUMAN'

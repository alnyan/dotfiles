" alnyan's nvimrc

filetype plugin indent on
" should I've installed syntastic instead?
syntax on

let g:airline_powerline_fonts = 0
" make sure CtrlP doesn't show unnecessary stuff
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git|hg|svn)|buil|build|target|doc|node_modules)$',
    \ 'file': '\v\.(o)$'
    \ }

" don't execute stuff from current directory
set exrc
set secure
" behold, ANSI-colors! My terminal is 256-color-capable
set t_Co=256
" display line numbers
set number
set numberwidth=5
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" make sure I don't write too much in a single line
set colorcolumn=100
" make sure I know where I am
set cursorline
" make cursor jump to next line when reaching end of one
" UPD Oct 04, 2018: cursor wrapping is not needed now
" set whichwrap+=<,>,h,l,[,]

set ignorecase
set smartcase

" yeah, I do use mouse sometimes
set mouse=a

set foldlevelstart=99

let g:ycm_server_python_interpreter='/usr/bin/python2'
let g:ycm_always_populate_location_list=1

" all the nicest stuff is here
call plug#begin('~/.vim/plugged')

Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-fugitive'
Plug 'tikhomirov/vim-glsl'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'crusoexia/vim-monokai'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ARM9/arm-syntax-vim'
Plug 'shirk/vim-gas'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'wlangstroth/vim-racket'

" LSP stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'

call plug#end()

" my favorite colorscheme, yay!
colorscheme monokai

set completeopt=menuone,noinsert,noselect
set shortmess+=c

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

set signcolumn=yes

lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    capabilities=capabilities,
    on_attach=on_attach
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" strip trailing spaces on file save
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! AutoFmt()
    if &syntax == "rust"
        execute "%!rustfmt --edition 2018"
    endif
endfun

autocmd! BufNewFile,BufRead *.vert,*.frag set ft=glsl
autocmd! BufNewFile,BufRead *.aic set ft=aic
autocmd BufWritePre * :call TrimWhitespace()
noremap <silent> <F4> :call ToggleSourceHeader()<Enter>
command! -nargs=1 MD :!mkdir -p <args>

" bind Ctrl+/ to comment toggling function
noremap <silent>  :nohlsearch<Enter>
inoremap <silent>  :nohlsearch<Enter>

noremap <silent> gA :Git add %<Enter>
noremap <silent> gC :Git commit<Enter>
noremap <silent> gR :Gread<Enter>

noremap gf :call AutoFmt()<Enter>

" indent guides color
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
hi IndentGuidesOdd      ctermbg=black
hi IndentGuidesEven     ctermbg=black

noremap <silent>  :CtrlPMRUFiles<Enter>
noremap <silent> <tab> :wincmd w<Enter>

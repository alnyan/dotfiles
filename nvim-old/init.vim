" alnyan's nvimrc

filetype plugin indent on
syntax on

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexrun'

let g:airline_powerline_fonts = 0

set completeopt=menuone,noinsert,noselect

set exrc
set secure
set t_Co=256
set number relativenumber
set numberwidth=5
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=100
set cursorline

set ignorecase
set smartcase

set mouse=a

set foldlevelstart=99

let g:rustfmt_autosave = 1

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'NoahTheDuke/vim-just'
Plug 'nastevens/vim-cargo-make'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'tamago324/nlsp-settings.nvim'

Plug 'L3MON4D3/LuaSnip'

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'

Plug 'airblade/vim-gitgutter'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'vim-airline/vim-airline'
Plug 'crusoexia/vim-monokai'

Plug 'tikhomirov/vim-glsl'
Plug 'DingDean/wgsl.vim'
Plug 'ARM9/arm-syntax-vim'
Plug 'shirk/vim-gas'
Plug 'wlangstroth/vim-racket'
Plug 'cespare/vim-toml'
Plug 'sennavanhoek/a64asm-vim'
Plug 'alisdair/vim-armasm'
Plug 'westeri/asl-vim'

Plug 'tpope/vim-fireplace'

Plug 'elkasztano/nushell-syntax-vim'

Plug 'lervag/vimtex'

call plug#end()

luafile ~/.config/nvim/setup.lua
source ~/.config/nvim/bindings.vim

let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
hi IndentGuidesOdd      ctermbg=black
hi IndentGuidesEven     ctermbg=black

colorscheme monokai

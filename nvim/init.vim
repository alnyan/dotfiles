" alnyan's nvimrc

filetype plugin indent on
" should I've installed syntastic instead?
syntax on

" nice arrow-like statusbar
let g:airline_powerline_fonts = 1
" make sure CtrlP doesn't show unnecessary stuff
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git|hg|svn)|buil|build)$',
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

let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_always_populate_location_list=1

" all the nicest stuff is here
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'alvan/vim-closetag'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'oblitum/YouCompleteMe'

call plug#end()

" my favorite colorscheme, yay!
colorscheme monokai

" strip trailing spaces on file save
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" bind Ctrl+/ to comment toggling function
noremap <silent>  :call NERDComment(0, "Toggle")<Enter>

" alnyan's nvimrc

filetype plugin indent on
" should I've installed syntastic instead?
syntax on

" nice arrow-like statusbar
let g:airline_powerline_fonts = 1
" make sure CtrlP doesn't show unnecessary stuff
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git|hg|svn)|buil|build|doc|node_modules)$',
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

let g:ycm_server_python_interpreter='/usr/bin/python2'
let g:ycm_always_populate_location_list=1

" all the nicest stuff is here
call plug#begin('~/.vim/plugged')

Plug 'derekwyatt/vim-scala'
Plug 'fidian/hexmode'
Plug 'tikhomirov/vim-glsl'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'alvan/vim-closetag'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
"Plug 'oblitum/YouCompleteMe'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ARM9/arm-syntax-vim'
Plug 'shirk/vim-gas'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ussrlongbow/vim-sqf'
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

call plug#end()

" my favorite colorscheme, yay!
colorscheme monokai

" strip trailing spaces on file save
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

" toggle source-header for C/C++
fun! ToggleSourceHeader()
    if &syntax == "c" || &syntax == "cpp"
        let l:fp = expand("%")
        let l:pidx = strridx(l:fp, '.')
        let l:pext = strpart(l:fp, l:pidx)
        let l:pbase = strpart(l:fp, 0, l:pidx)

        if l:fp =~ "^src\/" && (l:pext == ".cpp" || l:pext == ".c")
            let l:incdir = substitute(l:pbase, "^src\/", "include/", "g")

            if l:pext == ".cpp" && filereadable(l:incdir . ".hpp")
                execute "edit" l:incdir . ".hpp"
                return
            endif

            if filereadable(l:incdir . ".h")
                execute "edit" l:incdir . ".h"
                return
            endif
        elseif l:fp =~ "^include\/" && (l:pext == ".hpp" || l:pext == ".h")
            let l:srcdir = substitute(l:pbase, "^include\/", "src/", "g")

            if filereadable(l:srcdir . ".cpp")
                execute "edit" l:srcdir . ".cpp"
                return
            endif

            if filereadable(l:srcdir . ".c")
                execute "edit" l:srcdir . ".c"
                return
            endif
        endif

        " Get file type (h/c/cpp)
        if l:pext == ".cpp" || l:pext == ".c"
            " For .cpp's, try to search for .hpp first
            if l:pext == ".cpp" && filereadable(l:pbase . ".hpp")
                execute "edit" l:pbase . ".hpp"
                return
            endif

            if filereadable(l:pbase . ".h")
                execute "edit" l:pbase . ".h"
                return
            endif

            echo "Could not find corresponding header: " . l:pbase . ".h!"
        elseif l:pext == ".h" || l:pext == ".hpp" || l:pext == ".hh"
            if filereadable(l:pbase . ".cpp")
                execute "edit" l:pbase . ".cpp"
                return
            endif

            if filereadable(l:pbase . ".c")
                execute "edit" l:pbase . ".c"
                return
            endif

            echo "Could not find corresponding source: " . l:pbase . ".c!"
        endif
    elseif &syntax == "glsl"
        let l:fp = expand("%")
        let l:pidx = strridx(l:fp, '.')
        let l:pext = strpart(l:fp, l:pidx)
        let l:pbase = strpart(l:fp, 0, l:pidx)

        if l:pext == ".frag"
            if filereadable(l:pbase . ".vert")
                execute "edit" l:pbase . ".vert"
                return
            endif

            echo "Could not find corresponding vertex shader: " . l:pbase . ".frag!"
        elseif l:pext == ".vert"
            if filereadable(l:pbase . ".frag")
                execute "edit" l:pbase . ".frag"
                return
            endif

            echo "Could not find corresponding fragment shader: " . l:pbase . ".vert!"
        endif
    endif
endfun

autocmd! BufNewFile,BufRead *.vert,*.frag set ft=glsl
autocmd BufWritePre * :call TrimWhitespace()
noremap <silent> <F4> :call ToggleSourceHeader()<Enter>
command -nargs=1 MD :!mkdir -p <args>

" bind Ctrl+/ to comment toggling function
noremap <silent>  :nohlsearch<Enter>
inoremap <silent>  :nohlsearch<Enter>

noremap <F2> :grep -r<Space>

" indent guides color
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
hi IndentGuidesOdd      ctermbg=black
hi IndentGuidesEven     ctermbg=black

noremap <silent>  :CtrlPMRUFiles<Enter>
noremap <silent> <tab> :wincmd w<Enter>

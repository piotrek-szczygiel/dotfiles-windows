lua require('plugins')

if (has('autocmd') && !has('gui_running'))
  augroup colorset
    autocmd!
    let s:white = { 'gui': '#ABB2BF', 'cterm': '145', 'cterm16' : '7' }
    autocmd ColorScheme * call onedark#set_highlight('Normal', { 'fg': s:white })
  augroup END
endif

let g:indentLine_fileTypeExclude = ['json', 'markdown']

colorscheme onedark

set colorcolumn=120
set expandtab
set hidden
set ignorecase
set mouse=a
set number
set scrolloff=5
set shiftround
set shiftwidth=4
set smartcase
set splitbelow
set splitright
set tabstop=4
set wildmode=longest,list,full

let mapleader = ' '

nnoremap <silent> <leader>ve :e $MYVIMRC<cr>
nnoremap <silent> <leader>vr :source $MYVIMRC<cr>
nnoremap <silent> <leader>vp :PackerSync<cr>
nnoremap <silent> <leader><cr> :nohl<cr>

nnoremap <silent> <leader>, :bp<cr>
nnoremap <silent> <leader>. :bn<cr>
nnoremap <silent> <tab> :b#<cr>

nnoremap <silent> <C-\> :vsp<cr>
nnoremap <silent> <C-s> :w<cr>

nnoremap <silent> <C-p> :Telescope find_files<cr>
nnoremap <silent> <C-f> :Telescope live_grep<cr>

vnoremap <silent> <leader>y "+y<cr>
vnoremap <silent> <leader>p "+p<cr>

vnoremap < <gv
vnoremap > >gv

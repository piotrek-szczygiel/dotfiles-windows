source $VIMRUNTIME\mswin.vim

" Plugins {{{
call plug#begin(stdpath('data') . '/plugged')

Plug 'airblade/vim-rooter'
Plug 'dense-analysis/ale'
Plug 'justinmk/vim-sneak'
Plug 'lfilho/cosco.vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }

call plug#end()

let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_CommandMap = {'<C-k>': ['<Up>'], '<C-j>': ['<Down>']}
" }}}

" Settings {{{
set fileformat=unix
set foldmethod=marker
set hidden
set ignorecase
set list
set listchars=tab:⯈\ ,trail:·,extends:◣,precedes:◢,nbsp:○
set mouse=a
set path+=**
set scrolloff=5
set shiftround
set shiftwidth=4
set showbreak=⮎\ 
set smartcase
set splitbelow
set splitright
set termguicolors
set undofile
set updatetime=500
set wildmode=longest,list,full
" }}}

" Keybinds {{{
let mapleader = " "

vnoremap > >gv
vnoremap < <gv

nnoremap <silent> k gk
nnoremap <silent> j gj

nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vg :e $MYGVIMRC<CR>
nnoremap <silent> <leader>vr :source $MYVIMRC<CR>
nnoremap <silent> <leader>vp :source $MYVIMRC \| :PlugUpdate<CR>

nnoremap <silent> <leader>gf :set guifont=*<CR>
nnoremap <silent> <leader>tb :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
nnoremap <silent> <leader>tn :set number!<CR>
" }}}

" Appearance {{{
colorscheme gruvbox
set background=dark
set guifont=Fira\ Code:h16
" }}}

" Neovide {{{
let g:neovide_refresh_rate=144
let g:neovide_cursor_animation_length=0.05
let g:neovide_cursor_trail_length=0
let g:neovide_cursor_vfx_mode = "railgun"
" }}}

" Other {{{
" highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd CursorHold * checktime
" }}}

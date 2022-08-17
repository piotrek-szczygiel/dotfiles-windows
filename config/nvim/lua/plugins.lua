return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'akinsho/bufferline.nvim', config = function() require('bufferline').setup{} end }
  use 'airblade/vim-rooter'
  use 'editorconfig/editorconfig-vim'
  use 'joshdick/onedark.vim'
  use 'kyazdani42/nvim-web-devicons'
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
  use 'ntpeters/vim-better-whitespace'
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-lualine/lualine.nvim', config = function() require('lualine').setup() end }
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
  use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end }
  use 'sheerun/vim-polyglot'
  use 'tomtom/tcomment_vim'
  use 'Yggdroot/indentLine'
end)

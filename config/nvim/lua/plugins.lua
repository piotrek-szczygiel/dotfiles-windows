return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'airblade/vim-gitgutter'
  use 'airblade/vim-rooter'
  use 'editorconfig/editorconfig-vim'
  use 'joshdick/onedark.vim'
  use 'sheerun/vim-polyglot'
  use 'tomtom/tcomment_vim'
  use 'Yggdroot/indentLine'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
  }

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {{ 'nvim-lua/plenary.nvim' }}
  }
end)

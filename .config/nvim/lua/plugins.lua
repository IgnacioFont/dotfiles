return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'sainnhe/everforest' 
  use 'sainnhe/gruvbox-material' 
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use  'folke/which-key.nvim' 
  use 'folke/zen-mode.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
  use 'rebelot/kanagawa.nvim'
  use 'mfussenegger/nvim-dap'
end)

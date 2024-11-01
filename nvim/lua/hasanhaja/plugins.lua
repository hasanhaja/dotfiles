return {
  { "rose-pine/neovim", 
    name = "rose-pine", 
    config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { 
    "mbbill/undotree",
    lazy = true,
  },
  { 
    "tpope/vim-fugitive",
    lazy = true,
  },
  { 
    "lewis6991/gitsigns.nvim",
    lazy = true,
  },
  { 
    "numToStr/Comment.nvim",
    lazy = true,
  },
  { 
    "folke/zen-mode.nvim",
    lazy = true,
  },
}

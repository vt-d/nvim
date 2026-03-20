return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').install { 'rust', 'c', 'python', 'typescript' }
		end
	},

	{
		'https://github.com/neovim/nvim-lspconfig',
		lazy = false,
		config = function()
			require("config.lsp")
		end
	}
}

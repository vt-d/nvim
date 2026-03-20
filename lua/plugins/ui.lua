return {
	{ 'nvim-mini/mini.statusline', version = '*' , config = true, opts = { use_icons = true, }, },
	{ 'nvim-mini/mini.icons', version = '*' , config = true, },
	{ 'catppuccin/nvim', name = 'catppuccin', priority = 1000, },

	-- Telescope
	{
		'nvim-telescope/telescope.nvim', version = '*',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
		},
		opts = {
			extensions = {
				file_browser = {
					hijack_netrw = true,
					mappings = {
						["i"] = {},
						["n"] = {},
					},
				},
			},
		},
		config = function(_, opts) 
			local telescope = require('telescope')
			telescope.setup(opts)

			telescope.load_extension('file_browser')
		end
	},
}

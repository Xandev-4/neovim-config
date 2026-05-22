return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			integrations = {
				nvimtree = true,
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"savq/melange-nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		name = "vesper",
		config = function()
			require("vesper").setup({
				transparent = true,
			})
		end,
	},
	{
		"mellow-theme/mellow.nvim",
		lazy = false,
		priority = 1000,
	},
}

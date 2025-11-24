return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	priority = 1000,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			filters = {
				dotfiles = false, -- false = do NOT hide dotfiles
				custom = {}, -- ensure you’re not hiding node_modules here
				exclude = {}, -- leave empty unless you want to force-show paths
			},
			-- Don’t hide files ignored by Git (like node_modules)
			git = {
				enable = true,
				ignore = false, -- false = show Git-ignored files
			},
			-- Optional quality-of-life settings
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			renderer = {
				group_empty = true,
			},
		})
	end,
}

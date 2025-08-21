return {
	"coffebar/neovim-project",
	opts = {
		projects = { -- define project roots
			"~/coding",
			"~/.config/*",
			"~",
		},
		-- Exclude scratch directories
		session_manager_opts = {
			auto_session_suppress_dirs = { "~/scratch", "/tmp", "~/" },
		},
		picker = {
			type = "fzf-lua", -- one of "telescope", "fzf-lua", or "snacks"
		},
	},
	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "ibhagwan/fzf-lua" },
		{ "Shatur/neovim-session-manager" },
		{ "nvim-tree/nvim-tree.lua" },
	},
	lazy = false,
	priority = 100,
}

return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main", -- add this
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		-- NEW: own module, not nvim-treesitter.configs
		require("nvim-treesitter-textobjects").setup({
			-- NEW: no wrapping `textobjects = {}` key, these are top-level now

			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = { query = "@function.outer", desc = "Select outside a function" },
					["if"] = { query = "@function.inner", desc = "Select inside a function" },
					["ac"] = { query = "@class.outer", desc = "Select around a class" },
					["ao"] = { query = "@comment.outer", desc = "Select around a comment" },
					["ah"] = { query = "@heading.outer", desc = "Select around heading" },
					["ih"] = { query = "@heading.inner", desc = "Select inside heading" },
					["al"] = { query = "@list.outer", desc = "Around list" },
					["il"] = { query = "@list.inner", desc = "Inside list" },
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = true,
			},

			-- NOW in the same table as select — no duplicate key clash
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		})
	end,
}

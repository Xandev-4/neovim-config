return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			-- Replaces ensure_installed (idempotent, skips already-installed parsers)
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"c",
				"cpp",
				"git_config",
				"html",
				"css",
				"java",
				"javascript",
				"json",
				"luadoc",
				"python",
				"php",
				"rust",
				"sql",
				"typescript",
				"yaml",
				"markdown",
				"markdown_inline",
			})

			-- Replaces highlight = { enable = true } and indent = { enable = true }
			-- Main branch no longer auto-enables these; you wire them manually
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
				callback = function(args)
					-- pcall so it silently skips filetypes with no parser
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	-- Incremental selection is gone from main, this plugin brings it back
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>",
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>",
				},
			},
		},
	},
}

return {
	"nvim-mini/mini.pairs",
	version = "*",
	event = "InsertEnter",
	config = function()
		require("mini.pairs").setup({
			-- custom opts go here later if needed
		})
	end,
}

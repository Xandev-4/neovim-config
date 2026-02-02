require("core.lazy")
require("core.keymaps")
require("core.options")
require("fzf-lua").register_ui_select()

local transparent_groups = {
	"Normal",
	"NormalNC",
	"VertSplit",
	"LineNr",
	"SignColumn",
	"StatusLine",
	"StatusLineNC",
	"Pmenu",
	"PmenuSbar",
	"PmenuSel",
	"PmenuThumb",
}

for _, group in ipairs(transparent_groups) do
	vim.cmd(string.format("hi %s guibg=none ctermbg=none", group))
end

vim.opt.conceallevel = 2
vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })

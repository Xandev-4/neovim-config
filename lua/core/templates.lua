local M = {}

local templates_dir = vim.fn.stdpath("config") .. "/templates/"

-- Map file extension -> template filename
local template_map = {
	html = "skeleton.html",
	cpp = "skeleton.cpp",
	java = "skeleton.java",
	css = "skeleton.css",
}

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*",
	callback = function(args)
		local ext = vim.fn.fnamemodify(args.file, ":e")
		local tmpl = template_map[ext]
		if not tmpl then
			return
		end

		local path = templates_dir .. tmpl
		if vim.fn.filereadable(path) ~= 1 then
			return
		end

		-- Read template into the (empty) buffer
		vim.cmd("0r " .. vim.fn.fnameescape(path))
		vim.cmd("normal! Gdd") -- remove trailing blank line left by 0r

		-- Java: replace %CLASS% with the actual filename (without extension)
		if ext == "java" then
			local classname = vim.fn.fnamemodify(args.file, ":t:r")
			vim.cmd("silent! %s/%CLASS%/" .. classname .. "/g")
		end

		-- Jump cursor to %CURSOR% placeholder if present, then remove it
		local buf = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		for i, line in ipairs(lines) do
			local col = line:find("%%CURSOR%%")
			if col then
				lines[i] = line:gsub("%%CURSOR%%", "")
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
				vim.api.nvim_win_set_cursor(0, { i, col - 1 })
				vim.cmd("startinsert")
				break
			end
		end
	end,
})

return M

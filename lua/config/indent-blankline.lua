local api = vim.api

local exclude_ft = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha" }

require("indent_blankline").setup {

	buftype_exclude = { "terminal" },
	filetype_exclude = exclude_ft,

	show_end_of_line = false,
	show_current_context_start = false,
	show_current_context = true,
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
}

local gid = api.nvim_create_augroup("indent_blankline", { clear = true })
api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = gid,
	command = "IndentBlanklineDisable",
})

api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	group = gid,
	callback = function()
		if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
			vim.cmd([[IndentBlanklineEnable]])
		end
	end,
})


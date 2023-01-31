-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
	-- Enable or disable logging
	logging = true,

	filetype = {
		c = {
			function()
				return {
					exe = "clang-format",
					args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
					stdin = true,
					cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
				}
			end
		}
	}
}

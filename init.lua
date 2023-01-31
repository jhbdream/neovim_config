local api = vim.api
local utils = require("utils")

local core_conf_files = {
	"plugins.vim", -- all the plugins installed and their configurations
	"autocommands.vim", -- various autocommands
	"options.vim",
	"mapping.lua",
	"colorschemes.lua"
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
	local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
	local source_cmd = "source " .. path
	vim.cmd(source_cmd)
end

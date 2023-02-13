local api = vim.api

local core_conf_files = {
	"options.vim",
	"plug.vim",
	"plug_init.lua",
	"theme.vim",
	"autocmd.vim",
}

for _, name in ipairs(core_conf_files) do
	local path = string.format("%s/config/%s", vim.fn.stdpath("config"), name)
	local source_cmd = "source " .. path
	vim.cmd(source_cmd)
end


require("nvim-treesitter.configs").setup {

	ensure_installed = { "python", "c", "cpp", "make", "vim", "lua" },
	ignore_install = {}, -- List of parsers to ignore installing

	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { 'help' }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<CR>',
			node_incremental = '<CR>',
			node_decremental = '<BS>',
			scope_incremental = '<TAB>',
		}
	},

	rainbow = {
		enable = true,
		disable = { "html" },
		extended_mode = false,
		max_file_lines = nil,
	},

	-- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
	indent = {
		enable = true
	}
}

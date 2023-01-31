local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")

packer.init {
	git = {
		clone_timeout = 500, -- Timeout, in seconds, for git clones
		default_url_format = "git@github.com:/%s" -- 使用 ssh 协议加速下载
	},
}

-- 添加要安装的包
packer.startup {
	function(use)
		use { "wbthomason/packer.nvim", opt = true }

		use { "onsails/lspkind-nvim"}

		-- lsp
		use { "hrsh7th/nvim-cmp", config = [[require("config.nvim-cmp")]] }

		-- snippet 自定义代码片段补全
		use { "L3MON4D3/LuaSnip", run = "make install_jsregexp", config = [[require("config.luasnip")]] }
		use { "saadparwaiz1/cmp_luasnip" }

		use { "hrsh7th/cmp-nvim-lsp" }

		use {
			"ray-x/lsp_signature.nvim",
			--config = [[require("config.lsp_signature")]]
		}

		-- Collection of configurations for built-in LSP client
		use { "neovim/nvim-lspconfig", config = [[require("config.lsp")]] }

		use {
			"nvim-telescope/telescope.nvim", tag = "0.1.1",
			requires = { {"nvim-lua/plenary.nvim"} },
			config = [[require("config.telescope")]]
		}

		use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

		-- colorscheme
		use { "navarasu/onedark.nvim" }

		use {
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = [[require("config.statusline")]],
		}

		use {
			"akinsho/bufferline.nvim", event = "VimEnter",
			config = [[require("config.bufferline")]],
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
		}

		use {
			"nvim-tree/nvim-tree.lua",
			config = [[require("config.nvim-tree")]],
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly" -- optional, updated every week. (see issue #1193)
		}

		-- Automatic insertion and deletion of a pair of characters
		use { "Raimondi/delimitMate" }

		use {
			'johnfrankmorgan/whitespace.nvim',
	   -- 	config = function ()
	   -- 		require('whitespace-nvim').setup({
	   -- 			-- configuration options and their defaults

	   -- 			-- `highlight` configures which highlight is used to display
	   -- 			-- trailing whitespace
	   -- 			highlight = 'MiniTrailspace',

	   -- 			-- `ignored_filetypes` configures which filetypes to ignore when
	   -- 			-- displaying trailing whitespace
	   -- 			ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'gitcommit' },
	   -- 		})

	   -- 		-- remove trailing whitespace with a keybinding
	   -- 		vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
	   -- 	end
		}

		-- 代码高亮
		use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require("config.treesitter")]] }

		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "VimEnter",
			config = [[require("config.indent-blankline")]],
		}

		use { "RRethy/vim-illuminate",
			event = "VimEnter",
			config = [[require("config.illuminate")]],
		}

		use { 'mhartington/formatter.nvim',
			config = [[require("config.formatter")]],
		}

		-- Lua
		use {
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = [[require("config.todo")]],
		}

	end
}


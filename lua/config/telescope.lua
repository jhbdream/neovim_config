-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	},

	defaults = {
		prompt_prefix = "🔍 ",
		selection_caret = "🔭",

		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",

		mappings = {
			-- insert 模式映射
			i = {
				["<esc>"] = require('telescope.actions').close,
				["<Tab>"] = { "<C-O>:stopinsert<cr>", type = "command" },
			},

			-- normal 模式映射
			n = {
				["<Tab>"] = { ":startinsert<cr>", type = "command" },
			},
		},

		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.5,
				results_width = 0.8,
			},

			vertical = {
				mirror = false,
			},

			width = 0.80,
			height = 0.75,
			preview_cutoff = 100,
		},

		previewer = false,
		color_devicons = true,
	},

	pickers = {

		buffers = {
			previewer = false,
			sort_mru = true,
			initial_mode = "normal",
			ignore_current_buffer = true,
			mappings = {
				n = {
					['dd'] = require('telescope.actions').delete_buffer,
				}
			},
		},

		find_files = {
			previewer = false,
		},

		lsp_references = {
			trim_text = true,
			show_line =false,
			initial_mode = "normal"
		},

		lsp_document_symbols = {
			trim_text = true,
			show_line =false,
			initial_mode = "normal"
		},

		live_grep = {
			disable_coordinates = true,
			show_line =false,
			only_sort_text = false,
			previewer = false,
			dynamic_preview_title = true,
		},

		colorscheme = {
			enable_preview = true,
			initial_mode = "normal",
		},

		grep_string = {
			initial_mode = "normal",
			show_line =false,
		},
	},
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "find files" } )
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = "live grep search"} )
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = "list all buffers" } )
vim.keymap.set('n', '<leader>f', builtin.lsp_document_symbols, { desc = "list symbols" } )
vim.keymap.set('n', '<leader>b', builtin.grep_string, { desc = "grep current word" } )

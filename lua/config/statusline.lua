require('lualine').setup {
	options = {
		icons_enabled = true,

		theme = 'nightfly',

		component_separators = "|",
		section_separators = { left = '', right = ''},

		always_divide_middle = true,

		globalstatus = false,

		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},

	sections = {

		lualine_a = {
			'mode'
		},

		lualine_b = {
			'branch',

			{
				'diff',
				colored = false, -- Displays a colored diff status if set to true
				symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
			},

			{
				'filename',
				file_status = false,      -- Displays file status (readonly status, modified status)
				newfile_status = false,  -- Display new file status (new file means no write after created)
				path = 1,
				-- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory

				shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
			}
		},

		lualine_c = {
		},

		lualine_x = {
			{'encoding'},
			{'fileformat'},
			{
				'filetype',
				colored = true,   -- Displays filetype icon in color if set to true
				icon_only = true, -- Display only an icon for filetype
				icon = { align = 'right' }, -- Display filetype icon on the right hand side
				-- icon =    {'X', align='right'}
				-- Icon string ^ in table is ignored in filetype component
			}
		},

		lualine_y = {
			'progress',
			"location"
		},

		lualine_z = {
			{
				'diagnostics',
				colored = false,           -- Displays diagnostics status in color if set to true.
				sources = { 'nvim_diagnostic' },
				always_visible = true,   -- Show diagnostics even if there are none.
			}
		}
	},
}

local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")

local custom_attach = function(client, bufnr)
	-- Mappings.
	local map = function(mode, l, r, opts)
		opts = opts or {}
		opts.silent = true
		opts.buffer = bufnr
		keymap.set(mode, l, r, opts)
	end

	map("n", "K", vim.lsp.buf.hover, { desc = "code function hover" })

	api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local float_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always", -- show source in diagnostic popup window
				prefix = " ",
			}

			if not vim.b.diagnostics_pos then
				vim.b.diagnostics_pos = { nil, nil }
			end

			local cursor_pos = api.nvim_win_get_cursor(0)
			if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
				and #diagnostic.get() > 0
				then
				diagnostic.open_float(nil, float_opts)
			end

			vim.b.diagnostics_pos = cursor_pos
		end,
	})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

local lspconfig = require("lspconfig")

if utils.executable("clangd") then
	lspconfig.clangd.setup {
		-- on_attach = custom_attach,
		capabilities = capabilities,
		flags = {
		},
	}
else
	vim.notify("clangd not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- global config for diagnostic
diagnostic.config {
	underline = false,
    virtual_text = false,

--    virtual_text = {
--		prefix = '🦊',
--		spacing = 1,
--		source = true,
--		format = function(diagnostic)
--			return diagnostic.message
--		end
--	},

	signs = false,
	severity_sort = false,
	float = false,
}

fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInformation", { text = " ", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

-- 🤖🔥🐲🗻🏝️
--               diagnostic_virtual_text = '',
--               -- lsp sign            ﮻           ﯭ                ﳀ    
--    -- Code action
--    code_action_icon = '🏏', -- "",
--    -- code lens
--    code_lens_action_icon = '👓',
--    -- Diagnostics
--    diagnostic_head = '🐛',
--    diagnostic_err = '📛',
--    diagnostic_warn = '👎',
--    diagnostic_info = [[👩]],
--    diagnostic_hint = [[💁]],
--
--    diagnostic_head_severity_1 = '🈲',
--    diagnostic_head_severity_2 = '☣️',
--    diagnostic_head_severity_3 = '👎',
--    diagnostic_head_description = '👹',
--    diagnostic_virtual_text = '🦊',
--    diagnostic_file = '🚑',
--    -- Values
--    value_changed = '📝',
--    value_definition = '🐶🍡', -- it is easier to see than 🦕
--    side_panel = {
--      section_separator = '',
--      line_num_left = '',
--      line_num_right = '',
--      inner_node = '├○',
--      outer_node = '╰○',
--      bracket_left = '⟪',
--      bracket_right = '⟫',
--    },
--    -- Treesitter
--    match_kinds = {
--      var = ' ', -- "👹", -- Vampaire
--      method = 'ƒ ', --  "🍔", -- mac
--      ['function'] = ' ', -- "🤣", -- Fun
--      parameter = '  ', -- Pi
--      associated = '🤝',
--      namespace = '🚀',
--      type = ' ',
--      field = '🏈',
--      module = '📦',
--      flag = '🎏',
--    },
--    treesitter_defult = '🌲',
--    doc_symbols = '',

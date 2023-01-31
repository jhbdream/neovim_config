local cmp = require('cmp')
local lspkind = require("lspkind")

cmp.setup {

	snippet = {
		expand = function(args)
			require'luasnip'.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({

		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,

		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,

		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	}),

	sources = cmp.config.sources({
		{
			name = 'nvim_lsp',
			keyword_length = 2,
		},
	}),

	matching = {
		disallow_fuzzy_matching = false,
		disallow_partial_matching = false,
		disallow_prefix_unmatching = true,
	},
}


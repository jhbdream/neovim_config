-- Set up nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')
local compare = require('cmp.config.compare')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },

  completion = {
    keyword_length = 3,
  },

  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
    -- 禁止显示函数doc提示信息
    documentation = cmp.config.disable
  },

  matching = {
    disallow_fuzzy_matching = false,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },

  sorting = {
    priority_weight = 2,
    comparators = {
     compare.sort_text,
     -- compare.offset,
     -- compare.kind,
     -- compare.exact,
     -- compare.scopes,
     -- compare.score,
     -- compare.locality,
     -- compare.length,
     -- compare.order,
     -- compare.recently_used,
    },
  },

  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  }),

  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
    },
    -- For vsnip users.
    {
      name = 'vsnip',
    },

    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.

    {
      -- buffer 文件太多会卡顿
    	name = 'buffer',
      option = {
        keyword_length = 3,
        get_bufnrs = function()
          local buf = vim.api.nvim_get_current_buf()
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size > 256 * 1024 then -- 256K
            return {}
          end
          return { buf }
        end
      }
    },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline({ '/', '?' }, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
     { name = 'buffer' }
   }
 })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline(':', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
     { name = 'path' }
   }, {
     { name = 'cmdline' }
   })
 })

-- Set up lspconfig.
local keymap = vim.keymap
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities.textDocument.completion.completionItem.sortText = false

local on_attach = function(client, bufnr)

  -- Mappings.
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    keymap.set(mode, l, r, opts)
  end

  client.server_capabilities.semanticTokensProvider = nil

  map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
  map("n", "<C-]>", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<C-k>", vim.lsp.buf.signature_help)
  map("n", "<space>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
  map("n", "gr", vim.lsp.buf.references, { desc = "show references" })

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    map("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })
  end


end

require('lspconfig')['clangd'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- diagnostic config
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  signs = false,
  severity_sort = false,
  float = false,

  --virtual_text = {
  --prefix = '🦊',
  --spacing = 1,
  --source = true,
  --format = function(diagnostic)
  --return diagnostic.message
  --end
  --},
}

-- telescope
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
    -- prompt_prefix = '🙊 ',
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
      initial_mode = "insert"
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

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<leader>f', builtin.lsp_document_symbols, { desc = "list symbols" } )
vim.keymap.set('n', '<leader>b', builtin.grep_string, { desc = "grep current word" } )

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- nvim-tree
require("nvim-tree").setup()
vim.keymap.set("n", "<F1>", "<cmd>NvimTreeFindFileToggle<CR>", { silent = true, desc = "toggle nvim-tree" })

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  highlight = {
    enable = true,

    disable = function(lang, buf)
      local max_filesize = 1000 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    additional_vim_regex_highlighting = false,
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

  indent = {
    enable = true
  }
}

-- lsp signature_help
local cfg = {
	debug = false, -- set to true to enable debug logging
	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
	-- default is  ~/.cache/nvim/lsp_signature.log
	verbose = false, -- show debug line number

	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default

	max_height = 12, -- max height of signature floating_window
	max_width = 80, -- max_width of signature floating_window
	noice = false, -- set to true if you using noice to render markdown
	wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
	-- will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you do not want the PUM and floating win overlap

	floating_window_off_x = 2, -- adjust float windows x position.
	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
	-- can be either number or function, see examples

	close_timeout = 4000, -- close floating window after ms when laster parameter is entered
	fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = true, -- virtual hint enable
	hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
	hint_scheme = "String",
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	handler_opts = {
		border = "double"   -- double, rounded, single, shadow, none, or a table of borders
	},

	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

	padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 36, -- if you using shadow as border use this set the opacity
	shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

	select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key


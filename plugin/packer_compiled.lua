-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jihongbin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/jihongbin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/jihongbin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/jihongbin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jihongbin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { 'require("config.luasnip")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "git@github.com:/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { 'require("config.bufferline")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "git@github.com:/akinsho/bufferline.nvim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "git@github.com:/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "git@github.com:/saadparwaiz1/cmp_luasnip"
  },
  delimitMate = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/delimitMate",
    url = "git@github.com:/Raimondi/delimitMate"
  },
  ["formatter.nvim"] = {
    config = { 'require("config.formatter")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "git@github.com:/mhartington/formatter.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { 'require("config.indent-blankline")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "git@github.com:/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "git@github.com:/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "git@github.com:/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { 'require("config.statusline")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "git@github.com:/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    config = { 'require("config.nvim-cmp")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "git@github.com:/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { 'require("config.lsp")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "git@github.com:/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { 'require("config.nvim-tree")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "git@github.com:/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { 'require("config.treesitter")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "git@github.com:/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "git@github.com:/nvim-tree/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "git@github.com:/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "git@github.com:/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "git@github.com:/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "git@github.com:/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'require("config.telescope")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "git@github.com:/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { 'require("config.todo")' },
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "git@github.com:/folke/todo-comments.nvim"
  },
  ["vim-illuminate"] = {
    config = { 'require("config.illuminate")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/opt/vim-illuminate",
    url = "git@github.com:/RRethy/vim-illuminate"
  },
  ["whitespace.nvim"] = {
    loaded = true,
    path = "/home/jihongbin/.local/share/nvim/site/pack/packer/start/whitespace.nvim",
    url = "git@github.com:/johnfrankmorgan/whitespace.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("config.nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require("config.lsp")
time([[Config for nvim-lspconfig]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
require("config.todo")
time([[Config for todo-comments.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("config.telescope")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require("config.nvim-tree")
time([[Config for nvim-tree.lua]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require("config.luasnip")
time([[Config for LuaSnip]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
require("config.formatter")
time([[Config for formatter.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require("config.treesitter")
time([[Config for nvim-treesitter]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'bufferline.nvim', 'lualine.nvim', 'vim-illuminate', 'indent-blankline.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

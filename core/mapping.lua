local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

-- Go to a certain buffer
keymap.set("n", "<Tab>", '<cmd>BufferLinePick<CR>', { silent = true })
keymap.set("n", "<S-Tab>", '<cmd>BufferLinePickClose<CR>', { silent = true })

keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

keymap.set("n", "<C-k>", ":Format<CR>", { silent = true })
keymap.set("v", "<C-k>", ":Format<CR>", { silent = true })


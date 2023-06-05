local telescope = require("telescope.builtin")
local extensions = require("telescope").extensions

-- vim.keymap.set("n", "<leader>fe",  "<cmd>Ex<CR>")
vim.keymap.set("n", "<leader>ff",  function() telescope.find_files() end)
vim.keymap.set("n", "<leader>far", function() telescope.lsp_references() end)
vim.keymap.set("n", "<leader>fg", function() extensions.live_grep_args.live_grep_args() end)
vim.keymap.set("n", "<leader>fds", function() telescope.lsp_document_symbols() end)
vim.keymap.set("n", "<leader>fws", function() telescope.lsp_dynamic_workspace_symbols() end)

-- TODO: make this pretty
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")


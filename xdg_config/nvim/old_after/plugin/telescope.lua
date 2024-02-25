require("telescope").setup {

    extensions = {
        file_browser = {
            theme = "ivy",
            hijack_netrw = false,
            autodepth = true,
            depth = "nope",
        }
    }
}

local telescope = require("telescope.builtin")

require("telescope").load_extension("file_browser")

local extensions = require("telescope").extensions

-- vim.keymap.set("n", "<leader>fe",  "<cmd>Ex<CR>")
vim.keymap.set("n", "<leader>ff",  function() telescope.find_files() end, {desc = "[f]ind [f]iles"})
vim.keymap.set("n", "<leader>fh",  function() telescope.help_tags() end, {desc = "[f]ind [h]elp tags"})
vim.keymap.set("n", "<leader>fk",  function() telescope.keymaps() end, {desc = "[f]ind [k]eymaps"})
vim.keymap.set("n", "<leader>fb",  function() extensions.file_browser.file_browser() end, {desc = "[f]ile [b]rowser"})
vim.keymap.set("n", "<leader>far", function() telescope.lsp_references() end, {desc = "[f]ind [a]ll [r]eferences"})
vim.keymap.set("n", "<leader>fg",  function() extensions.live_grep_args.live_grep_args() end, {desc = "[f]ind text using [g]rep"})
vim.keymap.set("n", "<leader>fds", function() telescope.lsp_document_symbols() end, {desc = "[f]ind [d]ocument [s]ymbols"})
vim.keymap.set("n", "<leader>fws", function() telescope.lsp_dynamic_workspace_symbols() end, {desc = "[f]ind [w]orkspace [s]ymbols"})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("TelescopeStuff", {clear = true}),
    callback = function(ev)
        vim.keymap.set("n", "<leader>fcb", function ()
            extensions.file_browser.file_browser({path = ev.file})
        end, {desc = "[f]ile [b]rowser"})
    end}
)


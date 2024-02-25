return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim', "telescope-file-browser"},
    lazy = false,
    keys = {
        {"<leader>ff",  function() require("telescope.builtin").find_files() end, desc = "[f]ind [f]iles"},
        {"<leader>fh",  function() require("telescope.builtin").help_tags() end, desc = "[f]ind [h]elp tags" },
        {"<leader>fk",  function() require("telescope.builtin").keymaps() end, desc = "[f]ind [k]eymaps" },
        {"<leader>fb",  function() require("telescope").extensions.file_browser.file_browser() end, desc = "[f]ile [b]rowser" },
        {"<leader>far", function() require("telescope.builtin").lsp_references() end, desc = "[f]ind [a]ll [r]eferences" },
        {"<leader>fg",  function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "[f]ind text using [g]rep" },
        {"<leader>fds", function() require("telescope.builtin").lsp_document_symbols() end, desc = "[f]ind [d]ocument [s]ymbols" },
        {"<leader>fws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "[f]ind [w]orkspace [s]ymbols" },
    },
    config = function()
        require("telescope").setup({
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = false,
                    autodepth = true,
                    depth = "nope",
                }
            }
        })
        require("telescope").load_extension("file_browser")
    end
}

--require("telescope").setup 

--local telescope = require("telescope.builtin")

--require("telescope").load_extension("file_browser")

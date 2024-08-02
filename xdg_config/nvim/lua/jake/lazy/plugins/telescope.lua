return {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0"
        }
    },
    lazy = false,
    keys = {
        {"<leader>fe", function() vim.cmd.Ex() end, desc = "[f]ile [e]xplorer"},
        {"<leader>ff", function() require("telescope.builtin").find_files() end, desc = "[f]ind [f]iles"},
        {"<leader>fg",  function() require("telescope.builtin").git_files() end, desc = "[f]ind [g]it files" },
        {"<leader>fh",  function() require("telescope.builtin").help_tags() end, desc = "[f]ind [h]elp tags" },
        {"<leader>fk",  function() require("telescope.builtin").keymaps() end, desc = "[f]ind [k]eymaps" },
        {"<leader>far", function() require("telescope.builtin").lsp_references() end, desc = "[f]ind [a]ll [r]eferences" },
        {"<leader>frg",  function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "[f]ind text using [r]ip [g]rep" },
        {"<leader>fds", function() require("telescope.builtin").lsp_document_symbols() end, desc = "[f]ind [d]ocument [s]ymbols" },
        {"<leader>fws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "[f]ind [w]orkspace [s]ymbols" },
    },
    config = function()
        local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/__pycache__/*")
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = vimgrep_arguments
            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = false,
                    autodepth = true,
                    depth = "nope",
                }
            },
            pickers = {
                find_files = {
                    find_command = {"rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/__pycache__/*"},
                },
            }
        })
        require("telescope").load_extension("live_grep_args")
    end
}


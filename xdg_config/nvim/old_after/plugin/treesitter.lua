require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "jsonc",
        "lua",
        "python",
        "query",
        "r",
        "rust",
        "sql",
        "vim",
        "vimdoc",
        "yaml"
    },
    sync_install = false,
    highlight = {
        enable = true
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"}
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?"
        }
    },
}





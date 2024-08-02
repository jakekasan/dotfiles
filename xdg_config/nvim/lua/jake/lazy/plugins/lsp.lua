local utils = require("jake.utils")

return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "williamboman/mason.nvim",
        "folke/neodev.nvim"
    },
    lazy = false,
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.on_attach(function(_, bufnr)
            -- lsp_zero.default_keymaps({buffer = bufnr})
            local nmap = utils.make_map("n", {buffer = bufnr})
            local imap = utils.make_map("i", {buffer = bufnr})

            nmap("gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
            nmap("gd", function() vim.lsp.buf.definition() end, "[G]o to [d]efinition")
            nmap("gi", function() vim.lsp.buf.implementation() end, "[G] List [i]mplementation")
            nmap("K", function() vim.lsp.buf.hover() end, "Hover [K]??")
            nmap("]d", function() vim.diagnostic.goto_next() end, "Next [d] diagnostic")
            nmap("[d", function() vim.diagnostic.goto_prev() end, "Previous [d] diagnostic")
            ---@diagnostic disable-next-line: missing-parameter
            -- nmap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
            -- nmap("<leader>vd", function() vim.diagnostic.open_float() end)
            nmap("<leader>vca", function() vim.lsp.buf.code_action() end)
            nmap("<leader>vrr", function() vim.lsp.buf.references() end)
            nmap("<leader>vrn", function() vim.lsp.buf.rename() end)
            imap("<C-h>", function() vim.lsp.buf.signature_help() end, "Signature [h]elp")
        end)

        require("lspconfig").lua_ls.setup(
            lsp_zero.nvim_lua_ls({
                flags = { allow_incremental_sync = true, debounce_text_changes = 30 },
                settings = {
                    Lua = {
                        workspace = {
                            library = {
                                vim.fn.expand("$VIMRUNTIME/lua"),
                                vim.fn.stdpath("config") .. "/lua",
                                vim.fn.expand("~/.local/share/nvim/lazy/plenary.nvim/lua"),
                                vim.fn.expand("~/.local/share/nvim/lazy/*/lua")
                            }
                        }
                    }
                }
            })
        )
        lsp_zero.setup()
    end
}


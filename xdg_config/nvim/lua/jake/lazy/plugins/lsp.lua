return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "williamboman/mason.nvim",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
            local opts = {buffer = bufnr, remap = false}

            local function map(mode, mapping, func, desc)
                vim.keymap.set(mode, mapping, func, vim.tbl_extend("force", opts, {desc = desc}))
            end

            map("n", "gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
            map("n", "gd", function() vim.lsp.buf.definition() end, "[G]o to [d]efinition")
            map("n", "gi", function() vim.lsp.buf.implementation() end, "[G] List [i]mplementation")
            map("n", "K", function() vim.lsp.buf.hover() end, "Hover [K]??")
            map("n", "]d", function() vim.diagnostic.goto_next() end, "Next [d] diagnostic")
            map("n", "[d", function() vim.diagnostic.goto_prev() end, "Previous [d] diagnostic")
            ---@diagnostic disable-next-line: missing-parameter
            map("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
            map("n", "<leader>vd", function() vim.diagnostic.open_float() end)
            map("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
            map("n", "<leader>vrr", function() vim.lsp.buf.references() end)
            map("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
            map("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
        end)
        lsp_zero.setup()
    end
}


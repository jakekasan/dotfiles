local lsp = require("lsp-zero").preset({})

lsp.preset("recommended")
lsp.ensure_installed({
    "tsserver",
    "eslint",
    "lua_ls",
    "rust_analyzer",
    "pyright",
    "jdtls"
})

lsp.on_attach(function(_, bufnr)
    local opts = {buffer = bufnr, remap = false}

    local function map(mode, mapping, func, desc)
        vim.keymap.set(mode, mapping, func, vim.tbl_extend("force", opts, {desc = desc}))
    end

    map("n", "gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
    map("n", "gd", function() vim.lsp.buf.definition() end, "[G]o to [d]efinition")
    map("n", "K", function() vim.lsp.buf.hover() end, "Hover [K]??")
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    ---@diagnostic disable-next-line: missing-parameter
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require("neodev").setup({})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls({ flags = { allow_incremental_sync = false, debounce_text_changes = 30 }}))

-- Scala
require('lspconfig.configs').metals = {
  default_config = {
    name = "metals",
    cmd = {"metals"},
    filetypes = { "scala", "sbt", "java" },
    root_dir = require('lspconfig.util').root_pattern({'some-config-file'})
  }
}

require('lspconfig').metals.setup({})
lsp.setup()

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior}

cmp.setup({
    sources = {
        {name = "path"},
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {"buffer", keyword_length = 3},
        {"luasnip", keyword_length = 2}
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }
})


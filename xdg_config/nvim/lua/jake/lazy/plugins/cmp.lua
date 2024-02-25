return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path", -- Required
        "hrsh7th/cmp-nvim-lsp", -- Required
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",     -- Required
    },
    config = function()
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
        })
    end,
    keys = {
        { "<C-p>", function() require("cmp").mapping.select_prev_item(cmp_select) end, desc = ""},
        { "<C-n>", function() require("cmp").mapping.select_next_item(cmp_select) end, desc = ""},
        { "<C-y>", function() require("cmp").mapping.confirm({ select = true }) end, desc = ""},
        { "<C-Space>", function() require("cmp").mapping.complete() end, desc = ""},
    }
}


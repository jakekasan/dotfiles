local function map(mode, key, fn, desc)
    local opts = { desc = desc }
    vim.keymap.set(mode, key, fn, opts)
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        map("n", "<leader>ha", function() harpoon:list():append() end, "[a]dd to harpoon")
        map("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Show [h]arpoon [l]ist")
        map("n", "<leader>h1", function() harpoon:list():select(1) end, "Select [h]arpoon item [1]")
        map("n", "<leader>h2", function() harpoon:list():select(2) end, "Select [h]arpoon item [2]")
        map("n", "<leader>h3", function() harpoon:list():select(3) end, "Select [h]arpoon item [3]")
        map("n", "<leader>hn", function() harpoon:list():next() end, "[h]arpoon [n]ext")
        map("n", "<leader>hp", function() harpoon:list():prev() end, "[h]arpoon [p]revious")
    end,
}


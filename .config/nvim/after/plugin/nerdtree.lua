require("nvim-tree").setup {}

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.keymap.set("n", "<leader>ft", function()
            vim.cmd("NvimTreeToggle")
        end)
    end}
)


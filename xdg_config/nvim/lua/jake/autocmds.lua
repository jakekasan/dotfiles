local md_augroup = vim.api.nvim_create_augroup("MarkdownStuff", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    group = md_augroup,
    callback = function()
        vim.opt.wrap = true
    end
})


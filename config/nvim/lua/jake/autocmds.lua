local python = require("jake.python")

vim.api.nvim_create_autocmd("BufWrite", {
    pattern = "test_*.py",
    callback = function(args)
        local is_registered = "No"
        if python.file_registered(args.file) then
            is_registered = "Yes!"
        end
        print("Registered file " .. args.file .. "? " .. is_registered)
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "test_*.py",
    callback = function(args)
        python.register_file(args.file)
    end
})

local md_augroup = vim.api.nvim_create_augroup("MarkdownStuff", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    group = md_augroup,
    callback = function()
        vim.opt.wrap = true
    end
})


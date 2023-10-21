-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

require("tokyonight").setup({
    transparent = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = true },
        keywords = { italic = true }
    },
    on_highlights = function(hl, colors)
        -- hl.LineNr = {
        --     fg = colors.yellow
        -- }
        hl.CursorLineNr = {
            fg = colors.yellow
        }
    end
})

vim.cmd("colorscheme tokyonight")


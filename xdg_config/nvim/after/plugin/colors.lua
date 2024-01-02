vim.opt.background = "dark"

require("tokyonight").setup({
    style = "storm",
    transparent = false,
    dim_inactive = true,
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


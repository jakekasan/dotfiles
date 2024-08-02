return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "php",
        "python",
        "query",
        "ruby",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml"
      },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}


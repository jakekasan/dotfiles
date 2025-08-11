return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    lazy = false,
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}

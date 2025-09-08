return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  keys = {
    {
      "<leader>fb",
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
      desc = "[f]ile [b]rowser",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
